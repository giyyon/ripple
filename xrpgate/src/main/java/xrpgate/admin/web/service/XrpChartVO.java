package xrpgate.admin.web.service;

import java.io.Serializable;

public class XrpChartVO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private double lowVolume;
	
	private double highVolume;
	
	private double asksVolume;
	
	private double bidsVolume;
	
	private double spreadsVolume;
	
	private double closeVolume;
	
	private double beforeCloseVolume;
	
	private double counterVolume;
	
	private double baseVolume;
	
	private String startTime;

	public double getLowVolume() {
		return lowVolume;
	}

	public void setLowVolume(double lowVolume) {
		this.lowVolume = lowVolume;
	}

	public double getHighVolume() {
		return highVolume;
	}

	public void setHighVolume(double highVolume) {
		this.highVolume = highVolume;
	}

	public double getAsksVolume() {
		return asksVolume;
	}

	public void setAsksVolume(double asksVolume) {
		this.asksVolume = asksVolume;
	}

	public double getBidsVolume() {
		return bidsVolume;
	}

	public void setBidsVolume(double bidsVolume) {
		this.bidsVolume = bidsVolume;
	}

	public double getSpreadsVolume() {
		return spreadsVolume;
	}

	public void setSpreadsVolume(double spreadsVolume) {
		this.spreadsVolume = spreadsVolume;
	}

	public double getCloseVolume() {
		return closeVolume;
	}

	public void setCloseVolume(double closeVolume) {
		this.closeVolume = closeVolume;
	}

	public double getCounterVolume() {
		return counterVolume;
	}

	public void setCounterVolume(double counterVolume) {
		this.counterVolume = counterVolume;
	}

	public double getBaseVolume() {
		return baseVolume;
	}

	public void setBaseVolume(double baseVolume) {
		this.baseVolume = baseVolume;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public double getBeforeCloseVolume() {
		return beforeCloseVolume;
	}

	public void setBeforeCloseVolume(double beforeCloseVolume) {
		this.beforeCloseVolume = beforeCloseVolume;
	}
	
	
}
