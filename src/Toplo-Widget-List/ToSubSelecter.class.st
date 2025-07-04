Class {
	#name : #ToSubSelecter,
	#superclass : #ToListSelecter,
	#instVars : [
		'parentSelecter'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #initialization }
ToSubSelecter >> defaultCommandApplicationStrategy [

	^ BlImmediateCommandApplicationStrategy new
]

{ #category : #'api - hooks' }
ToSubSelecter >> onInstalledIn: anEventTarget [

	super onInstalledIn: anEventTarget.
	selectionModel uniqueId: selectionChangedEventClass.
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
