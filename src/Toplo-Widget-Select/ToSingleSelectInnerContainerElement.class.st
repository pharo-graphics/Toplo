Class {
	#name : #ToSingleSelectInnerContainerElement,
	#superclass : #ToSelectInnerContainerElement,
	#instVars : [
		'dataItemView'
	],
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #initialization }
ToSingleSelectInnerContainerElement >> addFakeView [

	self addChild: fakeView 
]

{ #category : #'api - hooks' }
ToSingleSelectInnerContainerElement >> onInstalledIn: aSelectElement [

	super onInstalledIn: aSelectElement.
	dataItemView := self newDatatItemViewInSelect: aSelectElement.
	dataItemView onInstalledIn: self.
	dataItemView addChild: textInputElement.
	self addChild: dataItemView
]

{ #category : #'api - hooks' }
ToSingleSelectInnerContainerElement >> onUninstalledIn: aSelectElement [

	dataItemView removeChild: textInputElement.
	dataItemView onUninstalledIn: aSelectElement.
	dataItemView removeFromParent.
	dataItemView := nil.
	super 	onUninstalledIn: aSelectElement
]

{ #category : #accessing }
ToSingleSelectInnerContainerElement >> refresh [

	| selectedIndex dataItem |
	selectedIndex := selectionModel isEmpty
		                 ifTrue: [ 0 ]
		                 ifFalse: [
		                 selectionModel firstIndex ].
	self inputTextField text: ''.
	selectedIndex isZero ifFalse: [ dataItem := dataAccessor at: selectedIndex ].
	dataItemViewBuilder cull: dataItemView cull: dataItem
]

{ #category : #initialization }
ToSingleSelectInnerContainerElement >> removeFakeView [

	self removeChild: fakeView 
]

{ #category : #initialization }
ToSingleSelectInnerContainerElement >> textInputElementClass [

	^ ToSelectTextInputElement 
]
