'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Fattening extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  Fattening.init({
    id_fattening: {
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
    bobot_fattening: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    keterangan: {
      type: DataTypes.ENUM,
      values: [
          'Terpenuhi',
          'Tidak Terpenuhi'
      ],
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
    modelName: 'Fattening',
    tableName: 'd_fattening'
  });
  return Fattening;
};