Class {
	#name : #ToAdditionalSelecter,
	#superclass : #ToListElementSelecter,
	#instVars : [
		'eventClass',
		'uniqueId',
		'parentSelecter'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #accessing }
ToAdditionalSelecter >> eventClass [

	^ eventClass
]

{ #category : #accessing }
ToAdditionalSelecter >> eventClass: anEventClass [

	eventClass ifNotNil: [ BlImmutableObjectChangeError signal ].
	eventClass := anEventClass
]

{ #category : #initialization }
ToAdditionalSelecter >> initialize [

	super initialize.
	selectionModel := ToAdditionalSelectionModel new
]

{ #category : #'api - hooks' }
ToAdditionalSelecter >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	selectionModel onInstalledIn: anElement.
	selectionModel uniqueId: uniqueId.
	operator := ToAdditionalSelectionModelOperator new eventClass: eventClass.
	operator onInstalledIn: anElement.
	parentSelecter recordSubSelecter: self

]

{ #category : #'api - hooks' }
ToAdditionalSelecter >> onUninstalledIn: anElement [

	parentSelecter unrecordSubSelecter: self.
	operator onUninstalledIn: anElement.
	operator := nil.
	selectionModel onUninstalledIn: anElement.
	selectionModel := nil.
	parentSelecter unrecordSubSelecter: self.
	super onUninstalledIn: anElement

]

{ #category : #accessing }
ToAdditionalSelecter >> parentSelecter: aCompositeSelecter [

	parentSelecter ifNotNil: [ BlImmutableObjectChangeError signal ].
	parentSelecter := aCompositeSelecter
]

{ #category : #accessing }
ToAdditionalSelecter >> uniqueId [

	^ uniqueId
]

{ #category : #accessing }
ToAdditionalSelecter >> uniqueId: aSymbol [

	uniqueId ifNotNil: [ BlImmutableObjectChangeError signal ].
	uniqueId := aSymbol
]
