// Helper databse yang dibuat
const joi = require('joi');
const { newError, errorHandler } = require('../utils/errorHandler');
const {Op} = require('sequelize');

class _fattening {
    constructor(db) {
        this.db = db;
    }

    getTernakFattening = async (req) => {
        try {
            // Get ternak in waiting list perkawinan
            const ternakFattening = await this.db.Ternak.findAll({
                attributes: ['id_ternak','id_fp','rf_id','jenis_kelamin'],
                include: [
                    {
                        model: this.db.Fase,
                        as: 'fase',
                        attributes: ['id_fp', 'fase']
                    },
                    {
                        model: this.db.Bangsa,
                        as: 'bangsa',
                        attributes: ['id_bangsa', 'bangsa']
                    },
                    {
                        model: this.db.Kandang,
                        as: 'kandang',
                        attributes: ['id_kandang', 'kode_kandang'],
                    },
                    {
                        model: this.db.Timbangan,
                        as: 'timbangan',
                        attributes: ['id_timbangan', 'berat', 'suhu'],
                    }
                ],

                where: {
                    id_fp: 13, // fattening
                    id_peternakan: req.dataAuth.id_peternakan
                }
            });

            // const fattening = await this.db.Fattening.findAll({
            //     attributes: ['bobot_fattening'],
            // });

            //
            value.id_peternakan = req.dataAuth.id_peternakan;
            //

            if (ternakFattening.length <= 0) newError(404, 'Data Ternak Waiting List Perkawinan tidak ditemukan', 'getternakFattening Service');

            let totalByKandang = {}

            for(let i = 0; i < ternakFattening.length; i++){
                if(ternakFattening[i].dataValues.kandang.kode_kandang != null){

                    ternakFattening[i].dataValues.berat = ternakFattening[i].dataValues.timbangan.length > 0 ? ternakFattening[i].dataValues.timbangan[ternakFattening[i].dataValues.timbangan.length - 1].dataValues.berat : null;
                    ternakFattening[i].dataValues.suhu = ternakFattening[i].dataValues.timbangan.length > 0 ? ternakFattening[i].dataValues.timbangan[ternakFattening[i].dataValues.timbangan.length - 1].dataValues.suhu : null;
                    delete ternakFattening[i].dataValues.timbangan;

                    totalByKandang[ternakFattening[i].dataValues.kandang.kode_kandang] ? totalByKandang[ternakFattening[i].dataValues.kandang.kode_kandang]++ : totalByKandang[ternakFattening[i].dataValues.kandang.kode_kandang] = 1;
                }
            }
            console.log();
            const ternakBetina = ternakFattening.filter((item) => item.dataValues.jenis_kelamin != null && item.dataValues.jenis_kelamin.toLowerCase() == 'betina');
            const ternakJantan = ternakFattening.filter((item) => item.dataValues.jenis_kelamin != null && item.dataValues.jenis_kelamin.toLowerCase() == 'jantan');

            return {
                code: 200,
                data: {
                    total: ternakFattening.length,
                    ternak_betina: ternakBetina.length,
                    ternak_jantan: ternakJantan.length,
                    total_per_kandang: totalByKandang,
                    list: ternakFattening,
                    // detail_fattening: fattening
                },
            }
        } catch (error) {
            return errorHandler(error);
        }
    }

    /// CONCERN !! GET
    getTernakMainFattening = async (req) => {
        try {
            // Get ternak in waiting list perkawinan
            const ternakMainFattening = await this.db.Fattening.findAll({
                where: {
                    id_peternakan: req.dataAuth.id_peternakan
                }
                // attributes: ['rf_id','id_fattening','id_ternak','id_kandang','bobot_fattening','rentang_fattening','id_jenis_pakan','interval_pakan','createdAt','updatedAt'],
            });

            if (ternakMainFattening.length <= 0) newError(404, 'Data Ternak Main Fattening tidak ditemukan', 'getternakMainFattening Service');

            return {
                code: 200,
                data: {
                    total: ternakMainFattening.length,
                    list: ternakMainFattening,
                },

            }
        } catch (error) {
            return errorHandler(error);
        }
    }

    /// CONCERN !! CREATE TABEL FATTENING
    createFattening = async (req) => {
        try {
            // Ambil data yang dibutuhkan dari permintaan (request)
            const {
                rf_id,
                // Hapus id_ternak dari sini
                id_kandang,
                bobot_fattening,
                keterangan,
                status_keluar,
            } = req.body;
    
            console.log(req.body);
    
            // Validasi data input menggunakan Joi atau sesuai kebutuhan Anda
            const schema = joi.object({
                rf_id: joi.string().required(),
                id_kandang: joi.number().required(),
                bobot_fattening: joi.number().allow(null),
                keterangan: joi.string().allow(null),
                status_keluar: joi.string().allow(null),
            });
    
            const { error } = schema.validate(req.body);
    
            if (error) {
                return newError(400, 'Invalid input data', 'createFattening Service');
            }
    
            // Cari "id_ternak" berdasarkan "rf_id" dari tabel "s_ternak"
            const ternak = await this.db.Ternak.findOne({ where: { rf_id } });
            // console.log(ternak.id_ternak)
    
            if (!ternak) {
                return newError(404, 'Ternak not found', 'createFattening Service');
            }
    
            // Buat data Fattening baru dengan "id_ternak" yang ditemukan
            const newFattening = await this.db.Fattening.create({
                id_peternakan: req.dataAuth.id_peternakan,
                id_ternak: ternak.id_ternak,
                id_kandang,
                bobot_fattening,
                keterangan,
                status_keluar,
                rf_id,
            });

            // await this.db.Timbangan.update({
            //     berat: bobot_fattening
            // },
            // {
            //     where: {
            //         id_ternak: ternak.id_ternak
            //     }
            // }
            // )

            if(bobot_fattening){
                const newTimbangan = await this.db.Timbangan.create({
                    berat: bobot_fattening,
                    suhu: 38,
                    id_ternak: ternak.id_ternak,
                    rf_id: rf_id
                }
                )
                return {
                    code: 201,
                    data: {newFattening,newTimbangan},
                };
            }


            // await this.db.Ternak.create({
            //     bobot: bobot_awal
            // })

            if (!newFattening) {
                return newError(500, 'Failed to create Fattening data', 'createFattening Service');
            }
            return {
                    code: 201,
                    data: {newFattening},
            };
            

        } catch (error) {
            console.log(error);
            return errorHandler(error);
        }
    }

        /// CONCERN !! CREATE TABEL FATTENING
        createTernakFattening = async (req) => {
            try {
                // Validate Data
                const schema = joi.object({
                    rf_id: joi.string().required(),
                    image: joi.string().allow(null),
                    jenis_kelamin: joi.string().allow(null),
                    id_bangsa: joi.number().allow(null),
                    berat: joi.number().allow(null),
                    suhu: joi.number().allow(null),
                    tanggal_lahir: joi.date().format(['YYYY-MM-DD', 'DD-MM-YYYY', 'YYYY-MM-DDTHH:mm:ss.SSSZ', 'DD-MM-YYYYTHH:mm:ss.SSSZ']).allow(null),
                    tanggal_masuk: joi.date().format(['YYYY-MM-DD', 'DD-MM-YYYY', 'YYYY-MM-DDTHH:mm:ss.SSSZ', 'DD-MM-YYYYTHH:mm:ss.SSSZ']).allow(null),
                    tanggal_keluar: joi.date().format(['YYYY-MM-DD', 'DD-MM-YYYY', 'YYYY-MM-DDTHH:mm:ss.SSSZ', 'DD-MM-YYYYTHH:mm:ss.SSSZ']).allow(null),
                    status_keluar: joi.string().allow(null),
                    id_dam: joi.number().allow(null),
                    id_sire: joi.number().allow(null),
                    id_fp: joi.number().allow(null),
                    id_status_ternak: joi.number().allow(null),
                    id_kandang: joi.number().allow(null)
                });
                const { error, value } = schema.validate(req.body);
                if (error) newError(400, error.details[0].message, 'createTernak Service');
    
                // Check is premium user
                if(req.dataAuth && !req.dataAuth.is_premium_farm){
                    // Check ternak count
                    const ternakCount = await this.db.Ternak.count({where: {id_peternakan: req.dataAuth.id_peternakan}});
                    console.log(ternakCount)
                    if(ternakCount >= config.premiumFarm.limitTernak) {
                        newError(403, `Maksimal ternak ${config.premiumFarm.limitTernak}, silahkan upgrade ke premium`, 'createTernak Service');
                    }
                } 
    
                // Validate tanggal_lahir
                if (value.tanggal_lahir && new Date(value.tanggal_lahir) > new Date()) newError(400, 'Tanggal lahir must be less than today', 'createTernak Service');
    
                // Validate tanggal_masuk
                if (value.tanggal_masuk && new Date(value.tanggal_masuk) > new Date()) newError(400, 'Tanggal masuk must be less than today', 'createTernak Service');
    
                // Validate fase
                if(value.jenis_kelamin && value.jenis_kelamin.toLowerCase() == 'jantan' && value.id_fp){
                    if(value.id_fp == 7){
                        newError(400, 'Jantan cannot be in fase Waiting List Perkawinan', 'createTernak Service')
                    }else if(value.id_fp == 9){
                        newError(400, 'Jantan cannot be in fase Kebuntingan', 'createTernak Service')
                    }else if(value.id_fp == 10){
                        newError(400, 'Jantan cannot be in fase Laktasi', 'createTernak Service')
                    }
                }
    
                // Check if Ternak already exist
                const ternak = await this.db.Ternak.findOne({where: {rf_id: value.rf_id}});
                if (ternak) newError(400, 'RFID Ternak sudah terdaftar', 'createTernak Service');
    
                // Add id_user to params
                value.id_peternakan = req.dataAuth.id_peternakan
                
                // Create new Ternak
                const add = await this.db.Ternak.create({
                    rf_id: value.rf_id,
                    id_peternakan: req.dataAuth.id_peternakan,
                    image: value.image,
                    jenis_kelamin: value.jenis_kelamin,
                    id_bangsa: value.id_bangsa,
                    tanggal_lahir: value.tanggal_lahir,
                    tanggal_masuk: value.tanggal_masuk || new Date(),
                    tanggal_keluar: value.tanggal_keluar,
                    status_keluar: value.status_keluar,
                    id_dam: value.id_dam,
                    id_sire: value.id_sire,
                    id_fp: value.id_fp,
                    id_status_ternak: value.id_status_ternak,
                    id_kandang: value.id_kandang
                });
                if (!add) newError(500, 'Gagal menambahkan ternak', 'createTernak Service');
    
                // Create suhu and berat
                if (value.berat || value.suhu) {
                    // Add Timbangan
                    const timbangan = await this.db.Timbangan.create({
                        id_ternak: add.id_ternak,
                        rf_id: add.rf_id,
                        berat: add.berat ? add.berat : 0,
                        suhu: add.suhu ? add.suhu : 0,
                        tanggal_timbang: new Date(),
                    });
                    if (!timbangan) newError(500, 'Gagal menambahkan timbangan', 'createTernak Service');
                }
    
                // Create riwayat fase
                if (value.id_fp) {
                    // Add Riwayat Fase
                    const riwayat_fase = await this.db.RiwayatFase.create({
                        id_peternakan: req.dataAuth.id_peternakan,
                        id_ternak: add.id_ternak,
                        id_fp: add.id_fp,
                        tanggal: new Date(),
                    });
                    if (!riwayat_fase) newError(500, 'Gagal menambahkan riwayat fase', 'createTernak Service');
                }
    
                return {
                    code: 200,
                    data: {
                        id: add.id_ternak,
                        rf_id: add.rf_id,
                        createdAt: add.createdAt
                    }
                };
            }
            catch (error) {
                return errorHandler(error);
            }
        }

    editFattening = async (req) => {
        try {
            // Ambil data yang dibutuhkan dari permintaan (request)
            const {
                id_fattening,
                rf_id,
                // Hapus id_ternak dari sini
                id_kandang,
                bobot_fattening,
                keterangan,
                status_keluar,
                
                
            } = req.body;
    
            console.log(req.body);
    
            // Validasi data input menggunakan Joi atau sesuai kebutuhan Anda
            const schema = joi.object({
                id_fattening: joi.number().required(),
                rf_id: joi.string().required(),
                id_kandang: joi.number().required(),
                bobot_fattening: joi.number().required(),
                keterangan: joi.string().required(),
                
                status_keluar: joi.string().required(),
                
            });
    
            // Cari "id_ternak" berdasarkan "rf_id" dari tabel "s_ternak"
            const ternak = await this.db.Ternak.findOne({ where: { rf_id } });

            const { error } = schema.validate(req.body);
    
            if (error) {
                return newError(400, 'Invalid input data', 'editFattening Service');
            }
    
            // Periksa apakah Fattening data dengan ID yang diberikan ada
            const existingFattening = await this.db.Fattening.findOne({ where: { id_fattening } });
    
            if (!existingFattening) {
                return newError(404, 'Fattening data not found', 'editFattening Service');
            }
    
            // Lakukan update data Fattening
            const updatedFattening = await existingFattening.update({
                id_fattening,
                id_ternak: ternak.id_ternak,
                id_kandang,
                bobot_fattening,
                keterangan,
                
                status_keluar,
                
                rf_id,
            });
    
            return {
                code: 200,
                data: updatedFattening,
            };
        } catch (error) {
            console.log(error);
            return errorHandler(error);
        }
    }

    deleteFattening = async (req) => {
        try {
            // Ambil rf_id yang akan digunakan untuk mencari data Fattening dari body request
            const { rf_id } = req.body;
    
            // Periksa apakah Fattening data dengan rf_id yang diberikan ada
            const existingFattening = await this.db.Fattening.findOne({ where: { rf_id } });
    
            if (!existingFattening) {
                return newError(404, 'Fattening data not found', 'deleteFatteningByQRIDFromBody Service');
            }
    
            // Hapus Fattening data
            await existingFattening.destroy();
    
            return {
                code: 204, // 204 adalah status No Content yang digunakan untuk operasi penghapusan yang sukses
                message: 'Fattening data deleted successfully',
            };
        } catch (error) {
            console.log(error);
            return errorHandler(error);
        }
    }
    
    
    

}

module.exports = (db) => new _fattening(db);