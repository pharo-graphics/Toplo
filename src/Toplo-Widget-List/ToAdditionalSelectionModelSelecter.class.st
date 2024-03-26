Class {
	#name : #ToAdditionalSelectionModelSelecter,
	#superclass : #ToEffectiveSelectionModelSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #'instance creation' }
ToAdditionalSelectionModelSelecter class >> on: aListElement [

	^ self new
		  onInstalledIn: aListElement;
		  yourself
]

{ #category : #accessing }
ToAdditionalSelectionModelSelecter >> eventClass [

	^ self subclassResponsibility 
]

{ #category : #'api - hooks' }
ToAdditionalSelectionModelSelecter >> onInstalledIn: aListElement [

	operator := ToAdditionalSelectionModelOperator on: aListElement withEventClass: self eventClass.
	selectionModel := aListElement newAdditionalSelectionModel.
	selectionModel onInstalledIn: aListElement.
	aListElement recordAdditionalSelecter: self.
	self beMultipleSelection.

]

{ #category : #'api - hooks' }
ToAdditionalSelectionModelSelecter >> onUninstalledIn: aListElement [

	aListElement unrecordAdditionalSelecter: self.
	operator onUninstalledIn: aListElement.
	selectionModel onUninstalledIn: aListElement.

]

{ #category : #accessing }
ToAdditionalSelectionModelSelecter >> uniqueId [

	^ self subclassResponsibility 
]
