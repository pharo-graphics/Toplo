Class {
	#name : 'ToActionRequiredEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'valuable'
	],
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 'accessing' }
ToActionRequiredEvent >> valuable: aValuable [

	valuable := aValuable
]

{ #category : 'accessing' }
ToActionRequiredEvent >> value: anObject [

	^ valuable value: anObject
]
