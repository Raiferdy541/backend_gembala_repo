'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class RiwayatFattening extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  RiwayatFattening.init({
    id_riwayat_fattening: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false
    },
    id_peternakan:{
      type: DataTypes.INTEGER,
      allowNull: false
    },
    rf_id: {
      type: DataTypes.STRING,
      allowNull: false
    },
    id_ternak: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    id_kandang: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    bobot_tahap_1: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    bobot_tahap_2: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    bobot_tahap_3: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    status_keluar: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    createdAt: {
      type: DataTypes.DATE,
      allowNull: false
    },
    updatedAt: {
      type: DataTypes.DATE,
      allowNull: false
    },
  }, {
    sequelize,
    modelName: 'RiwayatFattening',
    tableName: 'd_riwayat_fattening'
  });
  return RiwayatFattening;
};