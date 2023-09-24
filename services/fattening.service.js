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
    // getTernakMainFattening = async (req) => {
    //     try {

    //         const ternak = await this.db.Ternak.findOne({ where: { rf_id } });

    //         // Get ternak in waiting list perkawinan
    //         const ternakMainFattening = await this.db.Fattening.findAll({
    //             where: {
    //                 id_peternakan: req.dataAuth.id_peternakan
    //             }
    //             // attributes: ['rf_id','id_fattening','id_ternak','id_kandang','bobot_fattening','rentang_fattening','id_jenis_pakan','interval_pakan','createdAt','updatedAt'],
    //         });

    //         if (ternakMainFattening.length <= 0) newError(404, 'Data Ternak Main Fattening tidak ditemukan', 'getternakMainFattening Service');

    //         return {
    //             code: 200,
    //             data: {
    //                 total: ternakMainFattening.length,
    //                 list: ternakMainFattening,
    //             },

    //         }
    //     } catch (error) {
    //         return errorHandler(error);
    //     }
    // }

    getTernakMainFattening = async (req) => {
        try {
            // const ternak = await this.db.Ternak.findOne({ where: { rf_id } });
    
            // Get ternak in waiting list perkawinan
            const ternakMainFattening = await this.db.Fattening.findAll({
                where: {
                    id_peternakan: req.dataAuth.id_peternakan
                }
            });
    
            if (ternakMainFattening.length <= 0) newError(404, 'Data Ternak Main Fattening tidak ditemukan', 'getternakMainFattening Service');
    
            // Transform data structure as requested
            const transformedData = ternakMainFattening.reduce((result, item) => {
                const { id_fattening, rf_id, id_ternak, id_kandang, bobot_fattening, tahap_fattening, keterangan, status_keluar, createdAt, updatedAt } = item;
    
                // Check if the item already exists in the result
                if (!result[id_ternak]) {
                    result[id_ternak] = {
                        // id_fattening,
                        id_peternakan: req.dataAuth.id_peternakan,
                        rf_id,
                        id_ternak,
                        id_kandang,
                        tahapan_fattening: {
                            [tahap_fattening]: {
                                id_fattening,
                                bobot_fattening,
                                keterangan,
                                status_keluar,
                                createdAt,
                                updatedAt
                            }
                        }
                    };
                } else {
                    // If the item already exists, add the new entry to its history
                    result[id_ternak].tahapan_fattening[tahap_fattening] = {
                        id_fattening,
                        bobot_fattening,
                        keterangan,
                        status_keluar,
                        createdAt,
                        updatedAt
                    };
                }
    
                return result;
            }, {});
    
            const transformedArray = Object.values(transformedData);
    
            return {
                code: 200,
                data: {
                    total: transformedArray.length,
                    list: transformedArray,
                },
            };
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
                tahap_fattening,
                keterangan,
                status_keluar,
            } = req.body;
    
            console.log(req.body);
    
            // Validasi data input menggunakan Joi atau sesuai kebutuhan Anda
            const schema = joi.object({
                rf_id: joi.string().required(),
                id_kandang: joi.number().required(),
                tahap_fattening: joi.number().required(),
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
                tahap_fattening,
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
                    rf_id: rf_id,
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

    /// CONCERN !! CREATE TABEL TAHAP 2 FATTENING
    createFatteningTahapDua = async (req) => {
            try {
                // Ambil data yang dibutuhkan dari permintaan (request)
                const {
                    rf_id,
                    id_kandang,
                    bobot_fattening,
                    tahap_fattening,
                    keterangan,
                    status_keluar,
                } = req.body;
        
                console.log(req.body);
        
                // Validasi data input menggunakan Joi atau sesuai kebutuhan Anda
                const schema = joi.object({
                    rf_id: joi.string().required(),
                    id_kandang: joi.number().allow(null),
                    tahap_fattening: joi.number().allow(null),
                    bobot_fattening: joi.number().required(),
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
                    return newError(404, 'Ternak tidak terdaftar', 'createFattening Service');
                }

                // Cari "id_ternak" berdasarkan "rf_id" dari tabel "s_ternak"
                const ternakFat = await this.db.Fattening.findOne({ where: { rf_id } });
                // console.log(ternak.id_ternak)
        
                if (!ternakFat) {
                    return newError(404, 'Ternak bukan pada fase fattening', 'createFattening Service');
                }
        
                // Buat data Fattening baru dengan "id_ternak" yang ditemukan
                const newFattening = await this.db.Fattening.create({
                    id_peternakan: req.dataAuth.id_peternakan,
                    id_ternak: ternak.id_ternak,
                    id_kandang: ternakFat.id_kandang,
                    bobot_fattening,
                    tahap_fattening : 2,
                    keterangan,
                    status_keluar,
                    rf_id,
                });
    
                if(bobot_fattening){
                    const newTimbangan = await this.db.Timbangan.create({
                        berat: bobot_fattening,
                        suhu: 38,
                        id_ternak: ternak.id_ternak,
                        rf_id: rf_id,
                    }
                    )
                    return {
                        code: 201,
                        data: {newFattening,newTimbangan},
                    };
                }
    
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
    createFatteningTahapTiga = async (req) => {
            try {
                // Ambil data yang dibutuhkan dari permintaan (request)
                const {
                    rf_id,
                    id_kandang,
                    bobot_fattening,
                    tahap_fattening,
                    keterangan,
                    status_keluar,
                } = req.body;
        
                console.log(req.body);
        
                // Validasi data input menggunakan Joi atau sesuai kebutuhan Anda
                const schema = joi.object({
                    rf_id: joi.string().required(),
                    id_kandang: joi.number().allow(null),
                    tahap_fattening: joi.number().allow(null),
                    bobot_fattening: joi.number().required(),
                    keterangan: joi.string().required(),
                    status_keluar: joi.string().required(),
                });
        
                const { error } = schema.validate(req.body);
        
                if (error) {
                    return newError(400, 'Invalid input data', 'createFattening Service');
                }
        
                // Cari "id_ternak" berdasarkan "rf_id" dari tabel "s_ternak"
                const ternak = await this.db.Ternak.findOne({ where: { rf_id } });
                // console.log(ternak.id_ternak)
        
                if (!ternak) {
                    return newError(404, 'Ternak tidak terdaftar', 'createFattening Service');
                }

                // Cari "id_ternak" berdasarkan "rf_id" dari tabel "s_ternak"
                const ternakFat = await this.db.Fattening.findOne({ where: { rf_id } });
                // console.log(ternak.id_ternak)
        
                if (!ternakFat) {
                    return newError(404, 'Ternak bukan pada fase fattening', 'createFattening Service');
                }
        
        
                // Buat data Fattening baru dengan "id_ternak" yang ditemukan
                const newFattening = await this.db.Fattening.create({
                    id_peternakan: req.dataAuth.id_peternakan,
                    id_ternak: ternak.id_ternak,
                    id_kandang : ternakFat.id_kandang,
                    bobot_fattening,
                    tahap_fattening : 3,
                    keterangan,
                    status_keluar,
                    rf_id,
                });
                
                // CONCERN ADD RIWAYAT FATT
                const tahap1 = await this.db.Fattening.findOne({ where: { rf_id, tahap_fattening:1} });
                const tahap2 = await this.db.Fattening.findOne({ where: { rf_id, tahap_fattening:2} });
                const tahap3 = await this.db.Fattening.findOne({ where: { rf_id, tahap_fattening:3} });

                const newRiwayatFattening = await this.db.RiwayatFattening.create({
                    id_peternakan: req.dataAuth.id_peternakan,
                    id_ternak: ternak.id_ternak,
                    id_kandang : ternakFat.id_kandang,
                    bobot_tahap_1 : tahap1.bobot_fattening,
                    bobot_tahap_2 : tahap2.bobot_fattening,
                    bobot_tahap_3 : tahap3.bobot_fattening,
                    status_keluar,
                    rf_id,
                })

                // DELETE Query Data [KALO DI DELETE SEMUA DATA BERELASI AKAN MUSNAH]
                // SOLUSINYA BUAT TABEL BARU TERUS CREATE RIWAYATNYA

                const del = await this.db.Ternak.destroy({
                    where: {
                        id_ternak: ternakFat.id_ternak,
                        id_peternakan: req.dataAuth.id_peternakan
                    }
                });
                if (del <= 0) newError(500, 'Gagal menghapus ternak', 'deleteTernak Service');
    
                // if(bobot_fattening){
                //     const newTimbangan = await this.db.Timbangan.create({
                //         berat: bobot_fattening,
                //         suhu: 38,
                //         id_ternak: ternak.id_ternak,
                //         rf_id: rf_id,
                //     }
                //     )
                //     return {
                //         code: 201,
                //         data: {newFattening,newTimbangan},
                //     };
                // }
    
                if (!newFattening) {
                    return newError(500, 'Failed to create Fattening data', 'createFattening Service');
                }
                return {
                        code: 201,
                        data: {newFattening,newRiwayatFattening},
                };
                
    
            } catch (error) {
                console.log(error);
                return errorHandler(error);
            }
    }

    getTernakFatteningKeluar = async (req) => {
        try {
            const ternakFatteningTahap3 = await this.db.Fattening.findAll({
                where: {
                    id_peternakan: req.dataAuth.id_peternakan,
                    tahap_fattening: 3,
                }
            });
    
            if (ternakFatteningTahap3.length <= 0) {
                newError(404, 'Data Ternak Fattening Tahap 3 tidak ditemukan', 'getTernakFatteningTahap3 Service');
            }
    
            return {
                code: 200,
                data: {
                    total: ternakFatteningTahap3.length,
                    list: ternakFatteningTahap3,
                },
            };
        } catch (error) {
            return errorHandler(error);
        }
    }
    
    getRiwayatFattening = async (req) => {
        try {
            const riwayat_fattening = await this.db.RiwayatFattening.findAll({
                where: {
                    id_peternakan: req.dataAuth.id_peternakan,
                }
            });
    
            if (riwayat_fattening.length <= 0) {
                newError(404, 'Data Ternak Fattening Tahap 3 tidak ditemukan', 'getriwayat_fattening Service');
            }
    
            return {
                code: 200,
                data: {
                    total: riwayat_fattening.length,
                    list: riwayat_fattening,
                },
            };
        } catch (error) {
            return errorHandler(error);
        }
    }
    

    ////////////////////

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