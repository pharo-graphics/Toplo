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
ToAdditionalSelecter >> onInstalledIn: anEventTarget [

	super onInstalledIn: anEventTarget.
	selectionModel onInstalledIn: anEventTarget.
	selectionModel uniqueId: uniqueId.
	operator := ToAdditionalSelectionModelOperator new eventClass: eventClass.
	operator onInstalledIn: anEventTarget.
	parentSelecter recordSubSelecter: self

]

{ #category : #'api - hooks' }
ToAdditionalSelecter >> onUninstalledIn: anEventTarget [

	parentSelecter unrecordSubSelecter: self.
	operator onUninstalledIn: anEventTarget.
	operator := nil.
	selectionModel onUninstalledIn: anEventTarget.
	selectionModel := nil.
	parentSelecter unrecordSubSelecter: self.
	super onUninstalledIn: anEventTarget

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
