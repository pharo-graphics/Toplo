Class {
	#name : #ToAdditionalSelecter,
	#superclass : #ToEffectiveSelecter,
	#instVars : [
		'eventClass',
		'uniqueId'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #'instance creation' }
ToAdditionalSelecter class >> on: aListElement [

	^ self new
		  onInstalledIn: aListElement;
		  yourself
]

{ #category : #accessing }
ToAdditionalSelecter >> eventClass [

	^ eventClass
]

{ #category : #accessing }
ToAdditionalSelecter >> eventClass: anEventClass [

	eventClass := anEventClass
]

{ #category : #'api - hooks' }
ToAdditionalSelecter >> onInstalledIn: aListElement [

	operator := ToAdditionalSelectionModelOperator on: aListElement withEventClass: self eventClass.
	selectionModel := aListElement newAdditionalSelectionModel.
	selectionModel onInstalledIn: aListElement.
	aListElement recordAdditionalSelecter: self.
	self beMultipleSelection.

]

{ #category : #'api - hooks' }
ToAdditionalSelecter >> onUninstalledIn: aListElement [

	aListElement unrecordAdditionalSelecter: self.
	operator onUninstalledIn: aListElement.
	selectionModel onUninstalledIn: aListElement.

]

{ #category : #accessing }
ToAdditionalSelecter >> uniqueId [

	^ uniqueId
]

{ #category : #accessing }
ToAdditionalSelecter >> uniqueId: aSymbol [

	uniqueId := aSymbol
]
