package com.cyient.controller;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;
import org.springframework.test.annotation.Commit;


@Aspect
@Component
public class SiteSurveyAspect {
	
	public SiteSurveyAspect()
	{
		System.out.println(" site survey Aspect>>>>>>>");
	}
	
	 /*@Before("execution( * com.cyient.controller.SiteSurveyController.*(..))")         //point-cut expression
    public void logBeforeV1(JoinPoint joinPoint)
    {
        System.out.println("RFIDAssetController.logBeforeUser() : " + joinPoint.getSignature().getName());
        
        Object[] args= joinPoint.getArgs();
        for(Object t:args)
        	System.out.println("args"+t);
    }*/
}
