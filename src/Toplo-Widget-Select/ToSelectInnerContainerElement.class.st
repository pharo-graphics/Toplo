Class {
	#name : #ToSelectInnerContainerElement,
	#superclass : #ToElement,
	#instVars : [
		'fakeDataItem',
		'filtrable',
		'windowManager',
		'selectionModel',
		'dataAccessor',
		'fakeDataItemView',
		'dataItemViewBuilder',
		'dataItemViewFactory',
		'dataItemView'
	],
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #accessing }
ToSelectInnerContainerElement >> dataAccessor: aDataAccessor [

	dataAccessor := aDataAccessor
]

{ #category : #accessing }
ToSelectInnerContainerElement >> dataItemViewBuilder: aValuable [

	" aValuable takes 2 args: the dataItemView and the selected dataItem "
	dataItemViewBuilder := aValuable
]

{ #category : #accessing }
ToSelectInnerContainerElement >> dataItemViewFactory: aValuable [

	dataItemViewFactory := aValuable
]

{ #category : #initialization }
ToSelectInnerContainerElement >> defaultDataItemViewBuilder [

	^ [ :theView :theDataItem |
	  theView selectedDataTextField text:
		  (theDataItem ifNil: [ '' ] ifNotNil: [ :d | d asString ]) ]
]

{ #category : #initialization }
ToSelectInnerContainerElement >> defaultDataItemViewFactory [

	^ [ ToSingleDataItemView new ]
]

{ #category : #initialization }
ToSelectInnerContainerElement >> defaultLayout [

	^ BlLinearLayout new
]

{ #category : #accessing }
ToSelectInnerContainerElement >> filterString [ 

	^ self textInputElement filterString
]

{ #category : #accessing }
ToSelectInnerContainerElement >> filtrable: aBoolean [

	filtrable := aBoolean.
	self textInputElement selectFiltrable: aBoolean
]

{ #category : #initialization }
ToSelectInnerContainerElement >> initialize [

	super initialize.
	dataItemViewFactory := self defaultDataItemViewFactory.
	dataItemViewBuilder := self defaultDataItemViewBuilder.
]

{ #category : #accessing }
ToSelectInnerContainerElement >> inputTextField [

	^ self textInputElement inputTextField
]

{ #category : #initialization }
ToSelectInnerContainerElement >> installFakeDataItemViewIn: aSelectElement [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	fakeDataItemView ifNotNil: [ :fn |
		fn onUninstalledIn: self.
		fn removeFromParent ].

	fakeDataItemView := self newDatatItemViewInSelect: aSelectElement.
	fakeDataItemView onInstalledIn: self.
	dataItemViewBuilder cull: fakeDataItemView cull: fakeDataItem.
	fakeDataItemView id: #fakeNode.
	fakeDataItemView width: 0.
	fakeDataItemView constraintsDo: [ :c |
		c vertical matchParent.
		c linear vertical alignCenter ].

	" add the fake node (to keep a constant minimum height )"
	self addChild: fakeDataItemView
]

{ #category : #testing }
ToSelectInnerContainerElement >> isFiltrable [

	^ filtrable
]

{ #category : #testing }
ToSelectInnerContainerElement >> isSingleNode [

	^ true
]

{ #category : #initialization }
ToSelectInnerContainerElement >> newDatatItemViewInSelect: aSelectElement [

	| newNode |
	newNode := dataItemViewFactory value.
	newNode selectElement: aSelectElement.
	^ newNode
]

{ #category : #'api - hooks' }
ToSelectInnerContainerElement >> onInstalledIn: aSelectElement [

	self
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
	filtrable := aSelectElement isFiltrable.
	windowManager := aSelectElement windowManager.
	selectionModel := aSelectElement selectionModel.
	dataAccessor := aSelectElement dataAccessor.
	dataItemView := self newDatatItemViewInSelect: aSelectElement.
	dataItemView onInstalledIn: self.

	self refresh.

	self addChild: dataItemView.
	self installFakeDataItemViewIn: aSelectElement
]

{ #category : #'as yet unclassified' }
ToSelectInnerContainerElement >> onSelectionChangedInSelectElement: aSelectElement [

	aSelectElement showHidePlaceholder.
	self refresh.
	aSelectElement listElement notifyPrimarySelectionDirty.
	self requestLayout
]

{ #category : #'api - hooks' }
ToSelectInnerContainerElement >> onUninstalledIn: aSelectElement [

	dataItemView onUninstalledIn: aSelectElement.
	dataItemView removeFromParent.
	dataItemView := nil.
	selectionModel := nil.
	dataAccessor := nil.
	self uninstallFakeDataItemViewIn: aSelectElement

]

{ #category : #window }
ToSelectInnerContainerElement >> onWindowClosed [

	self textInputElement onWindowClosed
]

{ #category : #window }
ToSelectInnerContainerElement >> onWindowOpened [

	self textInputElement onWindowOpened
]

{ #category : #accessing }
ToSelectInnerContainerElement >> refresh [

	| selectedIndex dataItem |
	selectedIndex := selectionModel isEmpty
		                 ifTrue: [ 0 ]
		                 ifFalse: [
		                 selectionModel firstIndex ].
	self inputTextField text: ''.
	selectedIndex isZero ifFalse: [ dataItem := dataAccessor at: selectedIndex ].
	dataItemViewBuilder cull: dataItemView cull: dataItem
]

{ #category : #accessing }
ToSelectInnerContainerElement >> selectedDataTextField [

	^ self textInputElement selectedDataTextField
]

{ #category : #accessing }
ToSelectInnerContainerElement >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #accessing }
ToSelectInnerContainerElement >> textInputElement [

	^ dataItemView textInputElement
]

{ #category : #initialization }
ToSelectInnerContainerElement >> uninstallFakeDataItemViewIn: aSelectElement [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	fakeDataItemView ifNotNil: [ :fn |
		fn onUninstalledIn: self.
		fn removeFromParent ].
	fakeDataItemView := nil
]

{ #category : #accessing }
ToSelectInnerContainerElement >> windowManager [ 

	^ windowManager
]
