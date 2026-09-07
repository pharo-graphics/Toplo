Class {
	#name : #ToParameterizedHostTest,
	#superclass : #BlParameterizedHostTest,
	#instVars : [
		'space'
	],
	#category : #'Toplo-Tests-Core'
}

{ #category : #running }
ToParameterizedHostTest >> setUp [

	super setUp.
	space := self newTestingSpace.
	space windowExtent: 800@600
]
