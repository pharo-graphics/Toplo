Class {
	#name : #ToConfigurationAction,
	#superclass : #ToWidgetConfiguration,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Core-Configuration'
}

{ #category : #accessing }
ToConfigurationAction >> action: aBlock [

	action := aBlock
]

{ #category : #hook }
ToConfigurationAction >> applyOn: anElement [

	super applyOn: anElement.
	action cull: anElement
]

{ #category : #initialization }
ToConfigurationAction >> initialize [
	super initialize.
	
	action := [ :optionalThisElement | ]
]
