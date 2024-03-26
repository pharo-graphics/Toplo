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
	self beMultipleSelection.

]

{ #category : #'api - hooks' }
ToAdditionalSelectionModelSelecter >> onUninstalledIn: aListElement [

	operator onUninstalledIn: aListElement.
	selectionModel onUninstalledIn: aListElement.

]
