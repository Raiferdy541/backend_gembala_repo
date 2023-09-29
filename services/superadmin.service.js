// Helper databse yang dibuat
const joi = require('joi');
const {generateToken, hashPassword} = require('../utils/auth');
const config = require('../config/app.config')
const date = require('date-and-time');
const {newError, errorHandler} = require('../utils/errorHandler');
const cron = require('node-cron');
const { Op } = require("sequelize");
const {verifyNewAccount} = require('../utils/email_verify');

class _superAdmin{
    constructor(db){
        this.db = db;
    }
    // Get Data users
    getUsers = async (req) => {
        try{
            // Add query params
            req.query.role = 'admin';
            // Get data users
            const list = await this.db.AuthUser.findAll({ 
                attributes: ['id_user', 'image', 'nama_pengguna', 'email', 'nomor_telepon', 'role', 'status'],
                include: [
                    {
                        model: this.db.Peternakan,
                        as: 'peternakan',
                        attributes: ['id_peternakan', 'nama_peternakan', 'alamat', 'subscribe', 'postcode', 'longitude', 'latitude', 'alamat_postcode', 'token'],
                    }
                ],
                where : req.query });
            if(list.length <= 0) newError(404, 'Data Users tidak ditemukan', 'getUsers Service');

            return {
                code: 200,
                data: {
                    total: list.length,
                    list
                }
            };
        }catch (error){
            return errorHandler(error);
        }
    }

    // Get Peternakan
    getPeternakan = async (req) => {
        try{
            // Get data peternakan
            const list = await this.db.Peternakan.findAll({
                attributes: ['id_peternakan', 'nama_peternakan', 'alamat', 'subscribe', 'postcode', 'longitude', 'latitude', 'alamat_postcode', 'token'],
                include: [
                    {
                        model: this.db.AuthUser,
                        as: 'user',
                        attributes: ['id_user', 'image', 'nama_pengguna', 'email', 'nomor_telepon', 'role', 'status'],
                    }
                ],
                where : req.query });
            if(list.length <= 0) newError(404, 'Data Peternakan tidak ditemukan', 'getPeternakan Service');

            return {
                code: 200,
                data: {
                    total: list.length,
                    list
                }
            };
        }catch (error){
            return errorHandler(error);
        }
    }

    // Generate new toke for superadmin and bod 
    generateNewToken = async (req) => {
        try{
            // Validate request
            const schema = joi.object({
                id_peternakan: joi.number().required()
            });
            const {error, value} = schema.validate(req.body);
            if(error) newError(400, error.details[0].message, 'generateNewToken Service');
            
            // Generate new token
            const token = generateToken({ 
                id_user: req.dataAuth.id_user, 
                nama_pengguna: req.dataAuth.nama_pengguna, 
                role: req.dataAuth.role,
                status: req.dataAuth.status,
                id_peternakan: value.id_peternakan
            });

            return {
                code: 200,
                data: {
                    token,
                    expiresAt: date.format(date.addSeconds(new Date(), config.jwt.expiresIn), 'YYYY-MM-DD HH:mm:ss')
                }
            }
        }
        catch (error){
            return errorHandler(error);
        }
    }

    // Set farm to premium farm
    setPremiumFarm = async (req) => {
        try{
            // Validate request
            const schema = joi.object({
                id_peternakan: joi.number().required(),
                months: joi.number().required()
            });
            const {error, value} = schema.validate(req.body);
            if(error) newError(400, error.details[0].message, 'setPremiumFarm Service');

            // subcribe premium farm time
            const farmData = await this.db.Peternakan.findOne({ where: { id_peternakan: value.id_peternakan } });
            if(!farmData) newError(404, 'Peternakan tidak ditemukan', 'setPremiumFarm Service');

            const oldDate = farmData.dataValues.subscribe ? new Date(farmData.dataValues.subscribe) : new Date();
            const newDate = new Date(oldDate.setMonth(oldDate.getMonth() + value.months));

            // Update data peternakan
            const farm = await this.db.Peternakan.update({ subscribe: newDate}, { where: { id_peternakan: value.id_peternakan } });
            if(farm[0] <= 0) newError(500, 'Gagal update data peternakan', 'setPremiumFarm Service');

            return {
                code: 200,
                data: {
                    message: `Success to subscribe premium farm ${value.id_peternakan} for ${value.months} months, until ${newDate}`
                }
            }
        }
        catch (error){
            return errorHandler(error);
        }
    }

    // Set farm premium to free farm
    setFreeFarmAuto = function () {
        cron.schedule('0 0 * * *', async () => {
            // Update data farm
            await this.db.Peternakan.update({ subscribe: null}, { where: { subscribe: { [Op.lte]: new Date() } }});
        }
        , {
            scheduled: true,
            timezone: "Asia/Jakarta"
        });
    }

    // Set farm premium to free farm manual
    setFreeFarmManual = async (req) => {
        try{
            // Validate request
            const schema = joi.object({
                id_peternakan: joi.number().required()
            });
            const {error, value} = schema.validate(req.body);
            if(error) newError(400, error.details[0].message, 'setFreeFarmManual Service');

            // Check peternakan
            const farmData = await this.db.Peternakan.findOne({ where: { id_peternakan: value.id_peternakan, subscribe:{[Op.not]: null} } });
            if(!farmData) newError(400, `Peternakan with id ${value.id_peternakan} is not premium Peternakan`, 'setFreeFarmManual Service');

            // Update data peternakan
            const farm = await this.db.Peternakan.update({ subscribe: null}, { where: { id_peternakan: value.id_peternakan } });
            if(farm[0] <= 0) newError(500, 'Gagal update data peternakan', 'setFreeFarmManual Service');

            return {
                code: 200,
                data: {
                    message: `Success to set free premium farm ${value.id_peternakan}`
                }
            }
        }
        catch (error){
            return errorHandler(error);
        }
    }

    // CONCERN
    // Register Email

    /// Register Service
    register = async (req) => {
        const t = await this.db.sequelize.transaction();
        try{
            // Validate data
            const schema = joi.object({
                nama_pengguna: joi.string().min(4).max(30).required(),
                email: joi.string().email().required(),
                nomor_telepon: joi.string().required(),
                alamat: joi.string().required(),
                postcode: joi.string().required(),
                nama_peternakan: joi.string().required(),
                kata_sandi: joi.string().min(8).required(),
                ulangi_kata_sandi: joi.ref('kata_sandi')
            });
            const {error, value} = schema.validate(req.body);
            if (error) newError(400, error.details[0].message, 'Register Service');

            // Check if user exist
            const checkUsername = await this.db.AuthUser.findOne({where : {nama_pengguna: value.nama_pengguna}});
            if (checkUsername) newError(400, 'Username sudah terdaftar', 'Register Service');

            // check nomor telepon
            const checkNomorTelepon = await this.db.AuthUser.findOne({where : {nomor_telepon: value.nomor_telepon}});
            if (checkNomorTelepon) newError(400, 'Nomor telepon sudah terdaftar', 'Register Service');

            // check if email exist
            const checkEmail = await this.db.AuthUser.findOne({where : {email: value.email}});
            if (checkEmail) newError(400, 'Email sudah terdaftar', 'Register Service');

            // add peternakan
            const addPeternakan = await this.db.Peternakan.create({
                nama_peternakan: value.nama_peternakan,
                alamat: value.alamat,
                postcode: value.postcode,
                longitude: null,
                latitude: null,
                alamat_postcode: null
            }, {transaction: t});
            if(!addPeternakan) newError(400, 'Gagal menambahkan peternakan', 'Register Service');

            // Hash password
            value.kata_sandi = await hashPassword(value.kata_sandi);
            
            // Insert data
            const register = await this.db.AuthUser.create({
                nama_pengguna: value.nama_pengguna,
                email: value.email,
                role: 'admin',
                status: 'inactive',
                id_peternakan: addPeternakan.id_peternakan,
                nomor_telepon: value.nomor_telepon,
                kata_sandi: value.kata_sandi
            }, {transaction: t});
            if (!register) newError(400, 'Gagal registrasi', 'Register Service');

            // Send email verification
            verifyNewAccount(register);

            // Commit transaction
            await t.commit();

            return {
                code: 200,
                data: {
                    message: 'Email has been sent'
                }
            };
        }catch (error){
            await t.rollback();
            return errorHandler(error);
        }
    }

    /// Register Service
    registerActive = async (req) => {
        const t = await this.db.sequelize.transaction();
        try{
            // Validate data
            const schema = joi.object({
                nama_pengguna: joi.string().min(4).max(30).required(),
                email: joi.string().email().required(),
                nomor_telepon: joi.string().required(),
                alamat: joi.string().required(),
                postcode: joi.string().required(),
                nama_peternakan: joi.string().required(),
                kata_sandi: joi.string().min(8).required(),
                ulangi_kata_sandi: joi.ref('kata_sandi')
            });

            const {error, value} = schema.validate(req.body);
            if (error) newError(400, error.details[0].message, 'Register Service');

            // Check if user exist
            const checkUsername = await this.db.AuthUser.findOne({where : {nama_pengguna: value.nama_pengguna}});
            if (checkUsername) newError(400, 'Username sudah terdaftar', 'Register Service');

            // check nomor telepon
            const checkNomorTelepon = await this.db.AuthUser.findOne({where : {nomor_telepon: value.nomor_telepon}});
            if (checkNomorTelepon) newError(400, 'Nomor telepon sudah terdaftar', 'Register Service');

            // check if email exist
            const checkEmail = await this.db.AuthUser.findOne({where : {email: value.email}});
            if (checkEmail) newError(400, 'Email sudah terdaftar', 'Register Service');

            // add peternakan
            const addPeternakan = await this.db.Peternakan.create({
                nama_peternakan: value.nama_peternakan,
                alamat: value.alamat,
                postcode: value.postcode,
                longitude: null,
                latitude: null,
                alamat_postcode: null
            }, {transaction: t});
            if(!addPeternakan) newError(400, 'Gagal menambahkan peternakan', 'Register Service');

            // Hash password
            value.kata_sandi = await hashPassword(value.kata_sandi);
            
            // Insert data
            const register = await this.db.AuthUser.create({
                nama_pengguna: value.nama_pengguna,
                email: value.email,
                role: 'admin',
                status: 'active',
                id_peternakan: addPeternakan.id_peternakan,
                nomor_telepon: value.nomor_telepon,
                kata_sandi: value.kata_sandi
            }, {transaction: t});
            if (!register) newError(400, 'Gagal registrasi', 'Register Service');

            // CONCERN Generate new token

            // const accountBaru = await this.db.AuthUser.findOne({id_peternakan : addPeternakan.id_peternakan})

            // const peternakan = await this.db.Peternakan.findOne({ where: { id_peternakan: addPeternakan.id_peternakan } });

            // const tokenGen = generateToken({ 
            //     id_user: accountBaru.id_user, 
            //     nama_pengguna: accountBaru.nama_pengguna, 
            //     role: accountBaru.role,
            //     status: accountBaru.status,
            //     id_peternakan: accountBaru.id_peternakan
            // });

            // const updatePeternakan = await this.db.Peternakan.update(
            //     {token : tokenGen},
            //     {where : {id_peternakan: accountBaru.id_peternakan}}
            // )

            
            // return {
            // code: 200,
            // data: {
            //     token,
            //     expiresAt: date.format(date.addSeconds(new Date(), config.jwt.expiresIn), 'YYYY-MM-DD HH:mm:ss')
            //     }
            // }

            // Send email verification
            // verifyNewAccount(register);

            // End Concern

            // Commit transaction
            await t.commit();

            return {
                code: 200,
                data: {
                    message: 'Akun telah dibuat',
                    // token,
                    // expiresAt: date.format(date.addSeconds(new Date(), config.jwt.expiresIn), 'YYYY-MM-DD HH:mm:ss')
                }
            };
        }catch (error){
            await t.rollback();
            return errorHandler(error);
        }
    }

    
    /// DELETE AKUN DARI SUPERADMIN CONCERN
    deleteAccountViaSuperAdmin = async (req) => {
        try{
            // Validate data
            const schema = joi.object({
                id_user: joi.number().required()
            });
            const {error, value} = schema.validate(req.body);
            if (error) newError(400, error.details[0].message, 'DeleteAccount Service');

            
            const account = await this.db.AuthUser.findOne({ where: { id_user: value.id_user } });
            // if(!account) newError(400, error.details[0].message, 'Akun tidak ada');
            if(!account) newError(400,'Akun tidak ada');


            const peternakan = await this.db.Peternakan.findOne({ where: { id_peternakan: account.id_peternakan } });
            // console.log(account)
            // console.log(peternakan)

            const deletedPeternakan = await this.db.Peternakan.destroy({where: {id_peternakan :account.id_peternakan }});
            if (deletedPeternakan <= 0) newError(400, 'Gagal menghapus peternakan', 'DeletePeternakan Service');


            // Delete data
            const deletedAccount = await this.db.AuthUser.destroy({where: {id_user :value.id_user }});
            // if (deletedAccount <= 0) newError(400, 'Gagal menghapus akun', 'DeleteAccount Service');
            // console.log(deletedAccount)


            return {
                code: 200,
                data: {
                    id_user: account.id_user,
                    nama_pengguna: account.nama_pengguna,
                    id_peternakan : account.id_peternakan,
                    nama_peternakan : peternakan.nama_peternakan,
                    deletedAt: date.format(new Date(), 'YYYY-MM-DD HH:mm:ss')
                }
            }
        }catch(err){
            return errorHandler(err);
        }
    }

    // DELETE AKUN DARI SUPERADMIN CONCERN
    deleteAccountViaSuperAdminParams = async (req) => {
        try {
            // Validate data
            const schema = joi.object({
                id_user: joi.number().required()
            });
            const { error, value } = schema.validate(req.query); // Menggunakan req.params
            console.log(req.query)
            if (error) newError(400, error.details[0].message, 'DeleteAccount Service');

            const account = await this.db.AuthUser.findOne({ where: { id_user: value.id_user } });

            if (!account) newError(400, 'Akun tidak ada');

            const peternakan = await this.db.Peternakan.findOne({ where: { id_peternakan: account.id_peternakan } });

            const deletedPeternakan = await this.db.Peternakan.destroy({ where: { id_peternakan: account.id_peternakan } });

            if (deletedPeternakan <= 0) newError(400, 'Gagal menghapus peternakan', 'DeletePeternakan Service');

            // Delete data
            const deletedAccount = await this.db.AuthUser.destroy({ where: { id_user: value.id_user } });

            return {
                code: 200,
                data: {
                    id_user: account.id_user,
                    nama_pengguna: account.nama_pengguna,
                    id_peternakan: account.id_peternakan,
                    nama_peternakan: peternakan.nama_peternakan,
                    deletedAt: date.format(new Date(), 'YYYY-MM-DD HH:mm:ss')
                }
            };
        } catch (err) {
            return errorHandler(err);
        }
    };

    /// Update Account Service CONCERN
    updateAccount = async (req) => {
        // Validate data
        const schema = joi.object({
            id_user: joi.number().required(),
            nama_pengguna: joi.string().min(4).max(30).allow(null),
            nomor_telepon: joi.string().allow(null),
            email: joi.string().allow(null),
            role: joi.string().allow(null),
            status: joi.string().allow(null),
        });
        const {error, value} = schema.validate(req.body);
        if (error) newError(400, error.details[0].message, 'UpdateAccount Service');
        
        // Check user account
        const checkUser = await this.db.AuthUser.findOne({where : {id_user : value.id_user}});
        if (!checkUser) newError(400, 'Pengguna tidak ditemukan', 'UpdateAccount Service');

        // if (value.status !== "active" || value.status !== "inactive" || value.status !== null) newError(400, 'Pilihan Status Tidak Ada');

        // if (value.role !== "admin" || value.role !== "superadmin" || value.role !== null) newError(400, 'Pilihan Role Tidak Ada');

        // Update data
        if(value.nama_pengguna){
            // check username
            const checkUsername = await this.db.AuthUser.findOne({where : {
                nama_pengguna: value.nama_pengguna,
            }});

            // if (checkUsername) newError(400, 'Nama Pengguna sudah terdaftar', 'UpdateAccount Service');
            
            const updatedAccount = await this.db.AuthUser.update({
                nama_pengguna: value.nama_pengguna || checkUser.dataValues.nama_pengguna,
            }, {
                where: {id_user : value.id_user}
            });
        }
        if(value.nomor_telepon){
            // Check nomor telepon
            const checkNomorTelepon = await this.db.AuthUser.findOne({where : {
                nomor_telepon: value.nomor_telepon,
            }});

            // if (checkNomorTelepon) newError(400, 'Nomor telepon sudah terdaftar', 'UpdateAccount Service');

            const updatedAccount = await this.db.AuthUser.update({
                nomor_telepon: value.nomor_telepon || checkUser.dataValues.nomor_telepon,
            }, {
                where: {id_user : value.id_user}
            });
        }
        if(value.email){
            // Check nomor telepon
            const checkEmail = await this.db.AuthUser.findOne({where : {
                email: value.email,
            }});

            // if (checkEmail) newError(400, 'Email sudah terdaftar', 'UpdateAccount Service');

            const updatedAccount = await this.db.AuthUser.update({
                email: value.email || checkUser.dataValues.email,
            }, {
                where: {id_user : value.id_user}
            });
        }

        if(value.role == "admin" || value.role == "superadmin" ){
            const updatedAccount = await this.db.AuthUser.update({
                role: value.role || checkUser.dataValues.role,
            }, {
                where: {id_user : value.id_user}
            });
        }

        if(value.status == "active" || value.status == "inactive"){
            const updatedAccount = await this.db.AuthUser.update({
                status: value.status || checkUser.dataValues.status,
            }, {
                where: {id_user : value.id_user}
            });
        }

        const updatedUser = await this.db.AuthUser.findOne({where : {id_user : value.id_user}});


        // if (updatedAccount <= 0) newError(500, 'Gagal mengupdate data pengguna', 'UpdateAccount Service');
        
        return {
            code : 200,
            data : {
                updatedUser,
                updatedAt: date.format(new Date(), 'YYYY-MM-DD HH:mm:ss')
            }
        }
    }

    
    /// Update Peternakan Service
    updatePeternakan = async (req) => {
        // Validate data
        const schema = joi.object({
            id_user: joi.number().required(),
            nama_peternakan: joi.string().allow(null),
            alamat: joi.string().allow(null),
            postcode: joi.number().allow(null),
        });
        const {error, value} = schema.validate(req.body);
        if (error) newError(400, error.details[0].message, 'UpdatePeternakan Service');
        
        // Check user account
        const checkUser = await this.db.AuthUser.findOne({where : {id_user : value.id_user}});
        if (!checkUser) newError(400, 'Pengguna tidak ditemukan', 'UpdatePeternakan Service');
        const checkPeternakan = await this.db.Peternakan.findOne({where : {id_peternakan : checkUser.id_peternakan}});

        // Update data
        if(value.nama_peternakan){
            // check username
            // const checkUsername = await this.db.Peternakan.findOne({where : {
            //     nama_peternakan: value.nama_peternakan,
            // }});

            // if (checkUsername) newError(400, 'Nama Pengguna sudah terdaftar', 'UpdateAccount Service');
            
            const updatedAccount = await this.db.Peternakan.update({
                nama_peternakan: value.nama_peternakan
            }, {
                where: {id_peternakan : checkPeternakan.id_peternakan}
            });
        }
        if(value.alamat){
            // Check nomor telepon
            // const checkNomorTelepon = await this.db.Peternakan.findOne({where : {
            //     alamat: value.alamat,
            // }});

            // if (checkNomorTelepon) newError(400, 'Nomor telepon sudah terdaftar', 'UpdateAccount Service');

            const updatedAccount = await this.db.Peternakan.update({
                alamat: value.alamat 
            }, {
                where: {id_peternakan : checkPeternakan.id_peternakan}
            });
        }
        if(value.postcode){
            // Check nomor telepon
            // const checkEmail = await this.db.Peternakan.findOne({where : {
            //     email: value.email,
            // }});

            // if (checkEmail) newError(400, 'Email sudah terdaftar', 'UpdateAccount Service');

            const updatedAccount = await this.db.Peternakan.update({
                postcode: value.postcode
            }, {
                where: {id_peternakan : checkPeternakan.id_peternakan}
            });
        }

        const updatedPeternakan = await this.db.Peternakan.findOne({where : {id_peternakan : checkPeternakan.id_peternakan}});


        // if (updatedAccount <= 0) newError(500, 'Gagal mengupdate data pengguna', 'UpdateAccount Service');
        
        return {
            code : 200,
            data : {
                updatedPeternakan,
                updatedAt: date.format(new Date(), 'YYYY-MM-DD HH:mm:ss')
            }
        }
    }

}

module.exports = (db) => new _superAdmin(db);