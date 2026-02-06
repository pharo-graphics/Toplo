Class {
	#name : #ToBlElementForConfigurationTest,
	#superclass : #BlElement,
	#instVars : [
		'configurationCount'
	],
	#category : #'Toplo-Tests-Core-Configuration'
}

{ #category : #configuration }
ToBlElementForConfigurationTest >> applyConfiguration [ 

	super applyConfiguration.
	configurationCount := configurationCount + 1
]

{ #category : #accessing }
ToBlElementForConfigurationTest >> configurationCount [

	^ configurationCount
]

{ #category : #accessing }
ToBlElementForConfigurationTest >> configurationCount: anObject [

	configurationCount := anObject
]

{ #category : #initialization }
ToBlElementForConfigurationTest >> initialize [ 

	super initialize.
	configurationCount := 0.
	self ensureCanManageToploSkin
]
