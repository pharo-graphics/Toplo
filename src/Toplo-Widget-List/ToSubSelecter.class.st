Class {
	#name : #ToSubSelecter,
	#superclass : #ToListSelecter,
	#instVars : [
		'uniqueId',
		'parentSelecter'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #initialization }
ToSubSelecter >> initializeCommandApplier [ 

	super initializeCommandApplier
	"commandApplierEventHandler := ToQueueBasedCommandApplierEventHandler new."
	"commandApplierEventHandler weak: true"
]

{ #category : #'api - hooks' }
ToSubSelecter >> onInstalledIn: anEventTarget [


	super onInstalledIn: anEventTarget.
	selectionModel uniqueId: uniqueId.
	parentSelecter recordSubSelecter: self

]

{ #category : #'api - hooks' }
ToSubSelecter >> onUninstalledIn: anEventTarget [

	parentSelecter unrecordSubSelecter: self.
	super onUninstalledIn: anEventTarget

]

{ #category : #accessing }
ToSubSelecter >> parentSelecter [

	^ parentSelecter 
]

{ #category : #accessing }
ToSubSelecter >> parentSelecter: aCompositeSelecter [

	parentSelecter ifNotNil: [ BlImmutableObjectChangeError signal ].
	parentSelecter := aCompositeSelecter
]

{ #category : #accessing }
ToSubSelecter >> uniqueId [

	^ uniqueId
]

{ #category : #accessing }
ToSubSelecter >> uniqueId: aSymbol [

	uniqueId ifNotNil: [ BlImmutableObjectChangeError signal ].
	uniqueId := aSymbol
]
