Class {
	#name : #ToDividerBaseDragEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Widget-Pane'
}

{ #category : #accessing }
ToDividerBaseDragEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToDividerBaseDragEvent >> sourceEvent: aDragEvent [

	sourceEvent := aDragEvent
]
