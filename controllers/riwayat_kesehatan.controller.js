const { Router } = require('express');
const riwayatKesehatanService = require('../services/riwayat_kesehatan.service');
const response = require('../utils/response');
const authentication = require('../middlewares/authentication');
const { adminMiddleware } = require('../middlewares/authorization');

const riwayatKesehatanController = (db) => {
    const s$riwayatKesehatan = riwayatKesehatanService(db);
    const RiwayatKesehatanController = Router();

    /**
     * Get Data Riwayat Kesehatan
    */
    RiwayatKesehatanController.get('/', authentication, adminMiddleware, async (req, res, next) => {
        const detail = await s$riwayatKesehatan.getRiwayatKesehatan(req);
        response.sendResponse(res, detail);
    } );

    /**
     * Create Riwayat Kesehatan
     * @param {number} id_ternak
     * @param {number} id_penyakit
     * @param {date} tanggal_sakit
     * @param {number} id_kandang
     */
    RiwayatKesehatanController.post('/', authentication, adminMiddleware, async (req, res, next) => {
        const add = await s$riwayatKesehatan.createRiwayatKesehatan(req);
        response.sendResponse(res, add);
    });

    /**
     * Update Riwayat Kesehatan
     * @param {number} id_riwayat_kesehatan
     * @param {date} tanggal_sakit
     * @param {date} tanggal_sembuh
     * @param {string} gejala
     * @param {string} penanganan
     * @param {number} id_kandang
    */
    RiwayatKesehatanController.put('/', authentication, adminMiddleware, async (req, res, next) => {
        const edit = await s$riwayatKesehatan.updateRiwayatKesehatan(req);
        response.sendResponse(res, edit);
    });

    /**
     * Delete Riwayat Kesehatan
     * @param {number} id_riwayat_kesehatan
    */
    RiwayatKesehatanController.delete('/', authentication, adminMiddleware, async (req, res, next) => {
        const del = await s$riwayatKesehatan.deleteRiwayatKesehatan(req);
        response.sendResponse(res, del);
    });

    /**
     * Get total ternak sakit by penyakit
     */
    RiwayatKesehatanController.get('/total-sakit-by-penyakit', authentication, adminMiddleware, async (req, res, next) => {
        const detail = await s$riwayatKesehatan.getTotalTernakSakitByPenyakit(req);
        response.sendResponse(res, detail);
    });

    return RiwayatKesehatanController;
}

module.exports = riwayatKesehatanController;