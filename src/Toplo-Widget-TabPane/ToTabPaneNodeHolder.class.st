Class {
	#name : #ToTabPaneNodeHolder,
	#superclass : #ToTabNodeHolder,
	#instVars : [
		'innerPane'
	],
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #accessing }
ToTabPaneNodeHolder >> innerPane [

	^ innerPane
]

{ #category : #accessing }
ToTabPaneNodeHolder >> innerPane: anElement [

	innerPane := anElement
]
