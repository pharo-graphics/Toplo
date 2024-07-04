Class {
	#name : #ToAdditionalSelecter,
	#superclass : #ToListSelecter,
	#instVars : [
		'uniqueId',
		'parentSelecter'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #initialization }
ToAdditionalSelecter >> initialize [

	super initialize.
	commandApplierEventHandler weak: false.
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
ToAdditionalSelecter >> parentSelecter [

	^ parentSelecter 
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
