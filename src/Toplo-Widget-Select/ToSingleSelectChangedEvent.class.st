Class {
	#name : #ToSingleSelectChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'selectedData',
		'selectedIndex'
	],
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #accessing }
ToSingleSelectChangedEvent >> selectedData [

	^ selectedData
]

{ #category : #accessing }
ToSingleSelectChangedEvent >> selectedData: aData [

	selectedData := aData
]

{ #category : #accessing }
ToSingleSelectChangedEvent >> selectedIndex [

	^ selectedIndex
]

{ #category : #accessing }
ToSingleSelectChangedEvent >> selectedIndex: anInteger [

	selectedIndex := anInteger
]
