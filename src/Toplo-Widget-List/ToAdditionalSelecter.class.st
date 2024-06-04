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

{ #category : #'command application' }
ToAdditionalSelecter >> commandApplied: aCommand [ 

	eventTarget dispatchEvent: (self eventClass new
			 selectionModel: aCommand selectionModel;
			 yourself)
]

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
	operator := ToSelectionModelOperator new.
	selectionModel := ToAdditionalSelectionModel new
]

{ #category : #'api - hooks' }
ToAdditionalSelecter >> onInstalledIn: anEventTarget [


	super onInstalledIn: anEventTarget.
	selectionModel on: anEventTarget.
	selectionModel uniqueId: uniqueId.
	parentSelecter recordSubSelecter: self

]

{ #category : #'api - hooks' }
ToAdditionalSelecter >> onUninstalledIn: anEventTarget [

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
