Class {
	#name : #ToSecondarySelecter,
	#superclass : #ToCompositeSelecter,
	#instVars : [
		'primarySelecter'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #'api - hooks' }
ToSecondarySelecter >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	operator := ToSecondarySelectionModelOperator new.
	operator onInstalledIn: anElement.
	selectionModel := anElement newSecondarySelectionModel.
	selectionModel onInstalledIn: anElement
]

{ #category : #'api - hooks' }
ToSecondarySelecter >> onUninstalledIn: anElement [

	operator := ToSecondarySelectionModelOperator new.
	operator onInstalledIn: anElement.
	selectionModel := anElement newSecondarySelectionModel.
	selectionModel onInstalledIn: anElement.
	super onUninstalledIn: anElement.

]

{ #category : #accessing }
ToSecondarySelecter >> primarySelecter: aPrimarySelecter [

	primarySelecter := aPrimarySelecter
]

{ #category : #accessing }
ToSecondarySelecter >> subSelecterIndex [

	^ primarySelecter subSelecterIndex
]
