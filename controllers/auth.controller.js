const { Router } = require('express');
const response = require('../utils/response');
const authentication = require('../middlewares/authentication');
const s$auth = require('../services/auth.service');

const AuthController = Router();

/**
 * Login
 * @param {string} username
 * @param {string} password
 */

AuthController.post('/login', async (req, res, next) => {
    req.cookies = req.headers.cookie;
    const login = await s$auth.login(req.body);
    response.sendResponse(res, login);
});

/**
 * Register
 * @param {string} nama_lengkap
 * @param {string} username
 * @param {string} email
 * @param {string} no_hp
 * @param {string} alamat
 * @param {string} password
 * @param {string} repeat_password
 */

AuthController.post('/register', async (req, res, next) => {
    console.log('register');
    const register = await s$auth.register(req.body);
    response.sendResponse(res, register);
});

/**
 * Logout
 */

AuthController.post('/logout', async (req, res, next) => {
    const logout = await s$auth.logout(req, res);
    response.sendResponse(res, logout);
});

/**
 * Delete Account
 * @param {string} password
 */

AuthController.delete('/delete-account',  async (req, res, next) => {
    const deleteAccount = await s$auth.deleteAccount(req);
    response.sendResponse(res, deleteAccount);
});

/**
 * Update Account
 * @param {string} nama_lengkap
 * @param {string} username
 * @param {string} email
 * @param {string} no_hp
 * @param {string} alamat
 */

AuthController.put('/update-account',  async (req, res, next) => {
    const updateAccount = await s$auth.updateAccount(req);
    response.sendResponse(res, updateAccount);
});

/**
 * Update Password
 * @param {string} password
 * @param {string} new_password
 */

AuthController.put('/update-password',  async (req, res, next) => {
    const updatePassword = await s$auth.updatePassword(req);
    response.sendResponse(res, updatePassword);
});

/**
 * Verify
 * @param {string} token
 */
AuthController.post('/verify', async (req, res, next) => {
    const verify = await s$auth.verify(req);
    response.sendResponse(res, verify);
});

// /**
//  * Forgot Password
//  * @param {string} email
//  */
// AuthController.post('/forgot-password', async (req, res, next) => {
//     const forgotPassword = await s$auth.forgotPassword(req);
//     response.sendResponse(res, forgotPassword);
// });

/**
 * Activate Account
 */
AuthController.get('/verify-account',  async (req, res, next) => {
    const activateAccount = await s$auth.verifyAccount(req.query.token);
    // response.sendResponse(res, activateAccount);
    res.redirect('https://gembala.netlify.app')
});

module.exports = AuthController;