Class {
	#name : #ToAdditionalSelectionModel,
	#superclass : #ToSelectionModel,
	#instVars : [
		'uniqueId'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #updating }
ToAdditionalSelectionModel >> shift: aGap from: aStartIndex [

	"(self uniqueId = #group) ifTrue: [ self halt. 'shift: from: ' trace. aGap trace. ' ' trace. aStartIndex traceCr ]."
	super shift: aGap from: aStartIndex
]

{ #category : #accessing }
ToAdditionalSelectionModel >> uniqueId [

	^ uniqueId
]

{ #category : #accessing }
ToAdditionalSelectionModel >> uniqueId: aSymbol [

	uniqueId := aSymbol
]
