// Helper databse yang dibuat
const joi = require('joi');
const date = require('date-and-time');
const { log_error } = require('../utils/logging');
class _ternak{
    constructor(db){
        this.db = db;
    }
    // Get Data Ternak
    getTernak = async (req) => {
        try{
            // Add id_peternakan to params
            req.query.id_peternakan = req.dataAuth.id_peternakan
            req.query.status_keluar = null,
            req.query.tanggal_keluar = null
            // Query data
            const list = await this.db.Ternak.findAll({
                attributes : ['id_ternak', 
                'rf_id', 
                'image', 
                'jenis_kelamin', 
                'id_dam', 
                'id_sire', 
                'tanggal_lahir',
                'tanggal_masuk', 
                'tanggal_keluar', 
                'status_keluar', 
                'createdAt', 
                'updatedAt'],
                include: [
                    {
                        model: this.db.Bangsa,
                        as: 'bangsa',
                        attributes: ['id_bangsa', 'bangsa']
                    },
                    {
                        model: this.db.Kandang,
                        as: 'kandang',
                        attributes: ['id_kandang', 'kode_kandang', 'id_jenis_kandang', 'persentase_kebutuhan_pakan', 'id_jenis_pakan'],
                        include: [
                            {
                                model: this.db.JenisKandang,
                                as: 'jenis_kandang',
                                attributes: ['id_jenis_kandang', 'jenis_kandang']
                            },
                            {
                                model: this.db.JenisPakan,
                                as: 'jenis_pakan',
                                attributes: ['id_jenis_pakan', 'jenis_pakan']
                            }
                        ]
                    },
                    {
                        model: this.db.RiwayatKesehatan,
                        as: 'riwayat_kesehatan',
                        attributes: ['id_riwayat_kesehatan', 'id_penyakit', 'tanggal_sakit', 'tanggal_sembuh'],
                    },
                    {
                        model: this.db.Fase,
                        as: 'fase',
                        attributes: ['id_fp', 'fase']
                    },
                    {
                        model: this.db.StatusTernak,
                        as: 'status_ternak',
                        attributes: ['id_status_ternak', 'status_ternak']
                    },
                    {
                        model: this.db.StatusTernak,
                        as: 'status_ternak',
                        attributes: ['id_status_ternak', 'status_ternak']
                    },
                    {
                        model: this.db.Timbangan,
                        as: 'timbangan',
                        attributes: ['id_timbangan', 'berat', 'suhu']
                    }
                ],
                where : req.query,
                order : [['createdAt', 'DESC']]
            });
            
            if(list.length <= 0){
                return{
                    code: 404,
                    error: 'Data Ternak not found'
                }
            }
            
            for(let i = 0; i < list.length; i++){
                list[i].dataValues.penyakit = (list[i].riwayat_kesehatan.filter(item => item.tanggal_sembuh == null))
                list[i].dataValues.status_kesehatan = list[i].dataValues.penyakit.length > 0 ? 'Sakit' : "Sehat";
                list[i].dataValues.kebutuhan_pakan = ((list[i].dataValues.timbangan.length > 0 
                    ? list[i].dataValues.timbangan[list[i].dataValues.timbangan.length - 1].dataValues.berat 
                    : 0) * ((list[i].dataValues.kandang && list[i].dataValues.kandang.persentase_kebutuhan_pakan 
                        ? list[i].dataValues.kandang.persentase_kebutuhan_pakan 
                        : 0)/100)).toFixed(2);
                const umurHari =  list[i].dataValues.tanggal_lahir ? Math.round((new Date() - new Date(list[i].dataValues.tanggal_lahir))/(1000*60*60*24)) : 0;
                list[i].dataValues.umur = `${Math.floor(umurHari/30)} bulan ${umurHari%30} hari`;
                list[i].dataValues.berat = list[i].dataValues.timbangan.length > 0 ? list[i].dataValues.timbangan[list[i].dataValues.timbangan.length - 1].dataValues.berat : 0;
                list[i].dataValues.suhu = list[i].dataValues.timbangan.length > 0 ? list[i].dataValues.timbangan[list[i].dataValues.timbangan.length - 1].dataValues.suhu : 0;
                delete list[i].dataValues.riwayat_kesehatan;
                delete list[i].dataValues.timbangan;
            }

            return {
                code: 200,
                data: {
                    total: list.length,
                    list
                }
            };
        }catch (error){
            log_error('getTernak Service', error);
            return {
                code: 500,
                error
            }
        }
    }

    // Create new Ternak
    createTernak = async (req) => {
        try {
            // Validate Data
            const schema = joi.object({
                rf_id: joi.string().required(),
                image: joi.string().allow(null),
                jenis_kelamin: joi.string().allow(null),
                id_bangsa: joi.number().allow(null),
                berat: joi.number().allow(null),
                suhu: joi.number().allow(null),
                tanggal_lahir: joi.date().allow(null),
                tanggal_masuk: joi.date().allow(null),
                tanggal_keluar: joi.date().allow(null),
                status_keluar: joi.string().allow(null),
                id_dam: joi.number().allow(null),
                id_sire: joi.number().allow(null),
                id_fp: joi.number().allow(null),
                id_status_ternak: joi.number().allow(null),
                id_kandang: joi.number().allow(null)
            });

            const {error, value} = schema.validate(req.body);
            if(error){
                const errorDetails = error.details.map(i => i.message).join(',');
                return{
                    code: 400,
                    error: errorDetails
                }
            }

            // Check if Ternak already exist
            const ternak = await this.db.Ternak.findOne({
                where: {
                    rf_id: value.rf_id
                }
            });
            if(ternak){
                return{
                    code: 400,
                    error: 'RFID Ternak already exist'
                }
            }

            // Query Data
            // Add id_user to params
            value.id_peternakan = req.dataAuth.id_peternakan
            const add = await this.db.Ternak.create(value);
            if(add === null){
                return{
                    code: 400,
                    error: `Failed to create new Ternak`
                }
            }

           if(value.berat || value.suhu){
                // Add Timbangan
                const timbangan = await this.db.Timbangan.create({
                    id_ternak: add.id_ternak,
                    rf_id: add.rf_id,
                    berat: add.berat ? add.berat : 0,
                    suhu: add.suhu ? add.suhu : 0,
                    tanggal_timbang: new Date(),
                });
                if(timbangan === null){
                    return{
                        code: 400,
                        error: `Failed to create new Timbangan`
                    }
                }
            }

            return {
                code: 200,
                data: {
                    id: add.id_ternak,
                    rf_id: add.rf_id,
                    createdAt: date.format(add.createdAt, 'YYYY-MM-DD HH:mm:ss')
                }
            };
        }
        catch (error) {
            log_error('createTernak Service', error);
            return {
                code: 500,
                error
            }
        }
    }

    // Update Ternak
    updateTernak = async (req) => {
        try {
            const schema = joi.object({
                id_ternak: joi.number().required(),
                rf_id: joi.string().required(),
                image: joi.string().allow(null),
                jenis_kelamin: joi.string().allow(null),
                id_bangsa: joi.number().allow(null),
                berat: joi.number().allow(null),
                suhu: joi.number().allow(null),
                tanggal_lahir: joi.date().allow(null),
                tanggal_masuk: joi.date().allow(null),
                tanggal_keluar: joi.date().allow(null),
                status_keluar: joi.string().allow(null),
                id_dam: joi.number().allow(null),
                id_sire: joi.number().allow(null),
                id_fp: joi.number().allow(null),
                id_status_ternak: joi.number().allow(null),
                id_kandang: joi.number().allow(null)
            });

            const {error, value} = schema.validate(req.body);
            if(error){
                const errorDetails = error.details.map(i => i.message).join(',');
                return{
                    code: 400,
                    error: errorDetails
                }
            }

            const update = await this.db.Ternak.update({
                rf_id: value.rf_id,
                image: value.image,
                jenis_kelamin: value.jenis_kelamin,
                id_bangsa: value.id_bangsa,
                tanggal_lahir: value.tanggal_lahir,
                tanggal_masuk: value.tanggal_masuk,
                tanggal_keluar: value.tanggal_keluar,
                status_keluar: value.status_keluar,
                id_dam: value.id_dam,
                id_sire: value.id_sire,
                id_fp: value.id_fp,
                id_status_ternak: value.id_status_ternak,
                id_kandang: value.id_kandang
            }, {
                where: {
                    id_ternak: value.id_ternak,
                    id_peternakan: req.dataAuth.id_peternakan
                }
            });
            if(update <= 0){
                return{
                    code: 400,
                    error: `Failed to update Ternak`
                }
            }

            // Get data Timbangan
            const timbangan = await this.db.Timbangan.findAll({
                where: {
                    id_ternak: value.id_ternak
                },
                order: [
                    ['createdAt', 'DESC']
                ],
                limit: 1
            });
            if(timbangan.length > 0){
                // Update Timbangan
                const updateTimbangan = await this.db.Timbangan.update({
                    berat: value.berat ? value.berat : timbangan[0].dataValues.berat,
                    suhu: value.suhu ? value.suhu : timbangan[0].dataValues.suhu,
                }, {
                    where: {
                        id_timbangan: timbangan[0].dataValues.id_timbangan
                    }
                });
                if(updateTimbangan <= 0){
                    return{
                        code: 400,
                        error: `Failed to update Timbangan`
                    }
                }
            }
            
            return {
                code: 200,
                data: {
                    id: value.id_ternak,
                    rf_id: value.rf_id,
                    updatedAt: date.format(new Date(), 'YYYY-MM-DD HH:mm:ss')
                }
            };
        }
        catch (error) {
            log_error('updateTernak Service', error);
            return {
                code: 500,
                error
            }
        }
    }

    // Delete Ternak
    deleteTernak = async (req) => {
        try {
            // Validate Data
            const schema = joi.object({
                id_ternak: joi.number().required(),
            });

            const {error, value} = schema.validate(req.body);
            if(error){
                const errorDetails = error.details.map(i => i.message).join(',');
                return{
                    code: 400,
                    error: errorDetails
                }
            }

            // Query Data
            const del = await this.db.Ternak.destroy({
                where: {
                    id_ternak: value.id_ternak,
                    id_peternakan: req.dataAuth.id_peternakan
                }
            });
            if(del <= 0){
                return{
                    code: 400,
                    error: `Failed to delete Ternak`
                }
            }

            return {
                code: 200,
                data: {
                    id: value.id_ternak,
                    deletedAt: date.format(new Date(), 'YYYY-MM-DD HH:mm:ss')
                }
            };
        }
        catch (error) {
            log_error('deleteTernak Service', error);
            return {
                code: 500,
                error
            }
        }
    }

    // Ternak Keluar
    ternakKeluar = async (req) => {
        try {
            // Validate Data
            const schema = joi.object({
                id_ternak: joi.number().required(),
                status_keluar: joi.string().required(),
                tanggal_keluar: joi.date().required()
            });

            const {error, value} = schema.validate(req.body);
            if(error){
                const errorDetails = error.details.map(i => i.message).join(',');
                return{
                    code: 400,
                    error: errorDetails
                }
            }

            // Query Data
            const update = await this.db.Ternak.update({
                status_keluar: value.status_keluar,
                tanggal_keluar: value.tanggal_keluar
            }, {
                where: {
                    id_ternak: value.id_ternak,
                    id_peternakan: req.dataAuth.id_peternakan
                }
            });
            if(update <= 0){
                return{
                    code: 400,
                    error: `Failed to update Ternak`
                }
            }

            return {
                code: 200,
                data: {
                    id: value.id_ternak,
                    updatedAt: date.format(new Date(), 'YYYY-MM-DD HH:mm:ss')
                }
            };
        }
        catch (error) {
            log_error('ternakKeluar Service', error);
            return {
                code: 500,
                error
            }
        }
    }

    // Get data Indukan
    getDataIndukan = async (req) => {
        try {
            // Get data status ternak
            const statusTernak = await this.db.StatusTernak.findOne({
                where: {
                    status_ternak : 'Indukan'
                }
            });
            if(!statusTernak){
                return{
                    code: 400,
                    error: `Status Ternak Indukan not found`
                }
            }

            // Query Data
            const list = await this.db.Ternak.findAll({
                attributes : ['id_ternak', 
                'rf_id', 
                'image', 
                'jenis_kelamin', 
                'id_dam', 
                'id_sire', 
                'tanggal_lahir',
                'tanggal_masuk', 
                'tanggal_keluar', 
                'status_keluar', 
                'createdAt', 
                'updatedAt'],
                include: [
                    {
                        model: this.db.Bangsa,
                        as: 'bangsa',
                        attributes: ['id_bangsa', 'bangsa']
                    },
                    {
                        model: this.db.Kandang,
                        as: 'kandang',
                        attributes: ['id_kandang', 'kode_kandang', 'id_jenis_kandang', 'persentase_kebutuhan_pakan', 'id_jenis_pakan'],
                        include: [
                            {
                                model: this.db.JenisKandang,
                                as: 'jenis_kandang',
                                attributes: ['id_jenis_kandang', 'jenis_kandang']
                            },
                            {
                                model: this.db.JenisPakan,
                                as: 'jenis_pakan',
                                attributes: ['id_jenis_pakan', 'jenis_pakan']
                            }
                        ]
                    },
                    {
                        model: this.db.RiwayatKesehatan,
                        as: 'riwayat_kesehatan',
                        attributes: ['id_riwayat_kesehatan', 'id_penyakit', 'tanggal_sakit', 'tanggal_sembuh'],
                    },
                    {
                        model: this.db.Fase,
                        as: 'fase',
                        attributes: ['id_fp', 'fase']
                    },
                    {
                        model: this.db.StatusTernak,
                        as: 'status_ternak',
                        attributes: ['id_status_ternak', 'status_ternak']
                    },
                    {
                        model: this.db.Timbangan,
                        as: 'timbangan',
                        attributes: ['id_timbangan', 'berat']
                    }
                ],
                where : {
                    id_peternakan: req.dataAuth.id_peternakan,
                    id_status_ternak: statusTernak.dataValues.id_status_ternak
                },
                order : [['createdAt', 'DESC']]
            });
            
            if(list.length <= 0){
                return{
                    code: 404,
                    error: 'Data Ternak not found'
                }
            }
            
            for(let i = 0; i < list.length; i++){
                list[i].dataValues.penyakit = (list[i].riwayat_kesehatan.filter(item => item.tanggal_sembuh == null))
                list[i].dataValues.status_kesehatan = list[i].dataValues.penyakit.length > 0 ? 'Sakit' : "Sehat";
                list[i].dataValues.kebutuhan_pakan = ((list[i].dataValues.timbangan.length > 0 
                    ? list[i].dataValues.timbangan[list[i].dataValues.timbangan.length - 1].dataValues.berat 
                    : 0) * ((list[i].dataValues.kandang && list[i].dataValues.kandang.persentase_kebutuhan_pakan 
                        ? list[i].dataValues.kandang.persentase_kebutuhan_pakan 
                        : 0)/100)).toFixed(2);
                const umurHari =  list[i].dataValues.tanggal_lahir ? Math.round((new Date() - new Date(list[i].dataValues.tanggal_lahir))/(1000*60*60*24)) : 0;
                list[i].dataValues.umur = `${Math.floor(umurHari/30)} bulan ${umurHari%30} hari`;
                list[i].dataValues.berat = list[i].dataValues.timbangan.length > 0 ? list[i].dataValues.timbangan[list[i].dataValues.timbangan.length - 1].dataValues.berat : 0;
                list[i].dataValues.suhu = list[i].dataValues.timbangan.length > 0 ? list[i].dataValues.timbangan[list[i].dataValues.timbangan.length - 1].dataValues.suhu : 0;
                delete list[i].dataValues.riwayat_kesehatan;
                delete list[i].dataValues.timbangan;
            }

            return {
                code: 200,
                data: {
                    total: list.length,
                    list
                },
            };
        } catch (error) {
            log_error('getDataIndukan Service', error);
            return {
                code: 500,
                error
            }
        }
    }

    // Get data penjantan 
    getDataPejantan = async (req) => {
        try {
            // Get data status ternak
            const statusTernak = await this.db.StatusTernak.findOne({
                where: {
                    status_ternak : 'Pejantan'
                }
            });
            if(!statusTernak){
                return{
                    code: 400,
                    error: `Status Ternak Pejantan not found`
                }
            }

            // Query Data
            const list = await this.db.Ternak.findAll({
                attributes : ['id_ternak', 
                'rf_id', 
                'image', 
                'jenis_kelamin', 
                'id_dam', 
                'id_sire', 
                'tanggal_lahir',
                'tanggal_masuk', 
                'tanggal_keluar', 
                'status_keluar', 
                'createdAt', 
                'updatedAt'],
                include: [
                    {
                        model: this.db.Bangsa,
                        as: 'bangsa',
                        attributes: ['id_bangsa', 'bangsa']
                    },
                    {
                        model: this.db.Kandang,
                        as: 'kandang',
                        attributes: ['id_kandang', 'kode_kandang', 'id_jenis_kandang', 'persentase_kebutuhan_pakan', 'id_jenis_pakan'],
                        include: [
                            {
                                model: this.db.JenisKandang,
                                as: 'jenis_kandang',
                                attributes: ['id_jenis_kandang', 'jenis_kandang']
                            },
                            {
                                model: this.db.JenisPakan,
                                as: 'jenis_pakan',
                                attributes: ['id_jenis_pakan', 'jenis_pakan']
                            }
                        ]
                    },
                    {
                        model: this.db.RiwayatKesehatan,
                        as: 'riwayat_kesehatan',
                        attributes: ['id_riwayat_kesehatan', 'id_penyakit', 'tanggal_sakit', 'tanggal_sembuh'],
                    },
                    {
                        model: this.db.Fase,
                        as: 'fase',
                        attributes: ['id_fp', 'fase']
                    },
                    {
                        model: this.db.StatusTernak,
                        as: 'status_ternak',
                        attributes: ['id_status_ternak', 'status_ternak']
                    },
                    {
                        model: this.db.Timbangan,
                        as: 'timbangan',
                        attributes: ['id_timbangan', 'berat']
                    }
                ],
                where : {
                    id_peternakan: req.dataAuth.id_peternakan,
                    id_status_ternak: statusTernak.dataValues.id_status_ternak
                },
                order : [['createdAt', 'DESC']]
            });
            
            if(list.length <= 0){
                return{
                    code: 404,
                    error: 'Data Ternak not found'
                }
            }
            
            for(let i = 0; i < list.length; i++){
                list[i].dataValues.penyakit = (list[i].riwayat_kesehatan.filter(item => item.tanggal_sembuh == null))
                list[i].dataValues.status_kesehatan = list[i].dataValues.penyakit.length > 0 ? 'Sakit' : "Sehat";
                list[i].dataValues.kebutuhan_pakan = ((list[i].dataValues.timbangan.length > 0 
                    ? list[i].dataValues.timbangan[list[i].dataValues.timbangan.length - 1].dataValues.berat 
                    : 0) * ((list[i].dataValues.kandang && list[i].dataValues.kandang.persentase_kebutuhan_pakan 
                        ? list[i].dataValues.kandang.persentase_kebutuhan_pakan 
                        : 0)/100)).toFixed(2);
                const umurHari =  list[i].dataValues.tanggal_lahir ? Math.round((new Date() - new Date(list[i].dataValues.tanggal_lahir))/(1000*60*60*24)) : 0;
                list[i].dataValues.umur = `${Math.floor(umurHari/30)} bulan ${umurHari%30} hari`;
                list[i].dataValues.berat = list[i].dataValues.timbangan.length > 0 ? list[i].dataValues.timbangan[list[i].dataValues.timbangan.length - 1].dataValues.berat : 0;
                list[i].dataValues.suhu = list[i].dataValues.timbangan.length > 0 ? list[i].dataValues.timbangan[list[i].dataValues.timbangan.length - 1].dataValues.suhu : 0;
                delete list[i].dataValues.riwayat_kesehatan;
                delete list[i].dataValues.timbangan;
            }

            return {
                code: 200,
                data: {
                    total: list.length,
                    list
                },
            };
        } catch (error) {
            log_error('getDataIndukan Service', error);
            return {
                code: 500,
                error
            }
        }
    }
}

module.exports = (db) => new _ternak(db);