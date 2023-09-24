const { Router } = require('express');
const fatteningService = require('../services/fattening.service');
const response = require('../utils/response');
const authentication = require('../middlewares/authentication');
const { adminMiddleware } = require('../middlewares/authorization');

const fatteningController = (db) => {
    const s$fattening = fatteningService(db);
    const FatteningController = Router();

    
    /**
     * Get Fattening
     */
    FatteningController.get('/ternak', authentication, adminMiddleware, async (req, res, next) => {
        const list = await s$fattening.getTernakFattening(req);
        response.sendResponse(res, list);
    });

    /**
     * Get Fattening MAIN
     */

    FatteningController.get('/main_ternak', authentication, adminMiddleware, async (req, res, next) => {
            const list = await s$fattening.getTernakMainFattening(req);
            response.sendResponse(res, list);
    });

    FatteningController.post('/main_ternak', authentication, adminMiddleware, async (req, res, next) => {
        const list = await s$fattening.createFattening(req);
        response.sendResponse(res, list);
    });

    FatteningController.post('/tahap_dua', authentication, adminMiddleware, async (req, res, next) => {
        const list = await s$fattening.createFatteningTahapDua(req);
        response.sendResponse(res, list);
    });

    FatteningController.post('/tahap_tiga', authentication, adminMiddleware, async (req, res, next) => {
        const list = await s$fattening.createFatteningTahapTiga(req);
        response.sendResponse(res, list);
    });

    FatteningController.get('/keluar', authentication, adminMiddleware, async (req, res, next) => {
        const list = await s$fattening.getTernakFatteningKeluar(req);
        response.sendResponse(res, list);
    });

    
    FatteningController.get('/riwayat_fattening', authentication, adminMiddleware, async (req, res, next) => {
        const list = await s$fattening.getRiwayatFattening(req);
        response.sendResponse(res, list);
    });


    //////////////
    

    FatteningController.put('/main_ternak', authentication, adminMiddleware, async (req, res, next) => {
        const list = await s$fattening.editFattening(req);
        response.sendResponse(res, list);
    });

    FatteningController.delete('/main_ternak', authentication, adminMiddleware, async (req, res, next) => {
        const list = await s$fattening.deleteFattening(req);
        response.sendResponse(res, list);
    });

    return FatteningController;
}

module.exports = fatteningController;