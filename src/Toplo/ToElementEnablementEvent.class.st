Class {
	#name : #ToElementEnablementEvent,
	#superclass : #BlEvent,
	#instVars : [
		'enabled'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToElementEnablementEvent >> enabled [

	^ enabled
]

{ #category : #accessing }
ToElementEnablementEvent >> enabled: aBoolean [

	enabled := aBoolean
]
