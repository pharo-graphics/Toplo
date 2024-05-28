Class {
	#name : #ToSelectInnerContainerElement,
	#superclass : #ToElement,
	#instVars : [
		'fakeDataItem',
		'filtrable',
		'windowManager',
		'selectionModel',
		'dataAccessor',
		'dataItemViewBuilder',
		'dataItemViewFactory',
		'textInputElement',
		'fakeView'
	],
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #initialization }
ToSelectInnerContainerElement >> addFakeView [

	self subclassResponsibility 
]

{ #category : #accessing }
ToSelectInnerContainerElement >> dataItemViewBuilder: aValuable [

	" aValuable takes 2 args: the dataItemView and the selected dataItem "
	dataItemViewBuilder := aValuable.
	self refresh
]

{ #category : #initialization }
ToSelectInnerContainerElement >> defaultLayout [

	^ BlLinearLayout new
]

{ #category : #accessing }
ToSelectInnerContainerElement >> filterString [ 

	^ textInputElement filterString
]

{ #category : #accessing }
ToSelectInnerContainerElement >> filtrable: aBoolean [

	filtrable := aBoolean.
	textInputElement selectFiltrable: aBoolean
]

{ #category : #accessing }
ToSelectInnerContainerElement >> inputTextField [

	^ textInputElement inputTextField
]

{ #category : #initialization }
ToSelectInnerContainerElement >> installFakeViewIn: aSelectElement [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	fakeView ifNotNil: [ :fn |
		fn onUninstalledIn: self.
		fn removeFromParent ].

	fakeView := self newDatatItemViewInSelect: aSelectElement.
	fakeView onInstalledIn: self.
	dataItemViewBuilder cull: fakeView cull: nil cull: fakeDataItem.
	fakeView id: #fakeNode.
	fakeView width: 0.


	" add the fake node (to keep a constant minimum height )"
	self addFakeView
]

{ #category : #testing }
ToSelectInnerContainerElement >> isFiltrable [

	^ filtrable
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
	dataItemViewFactory := aSelectElement dataItemViewFactory.
	dataItemViewBuilder := aSelectElement dataItemViewBuilder.
	filtrable := aSelectElement isFiltrable.
	windowManager := aSelectElement windowManager.
	selectionModel := aSelectElement selectionModel.
	dataAccessor := aSelectElement dataAccessor.
	textInputElement := self textInputElementClass new.
	textInputElement onInstalledIn: self.
	self installFakeViewIn: aSelectElement
]

{ #category : #'accessing - selection' }
ToSelectInnerContainerElement >> onSelectionChangedInSelectElement: aSelectElement [

	aSelectElement showHidePlaceholder.
	self refresh.
	aSelectElement listElement notifyPrimarySelectionDirty.
	self requestLayout
]

{ #category : #'api - hooks' }
ToSelectInnerContainerElement >> onUninstalledIn: aSelectElement [

	selectionModel := nil.
	dataAccessor := nil.
	self uninstallFakeViewIn: aSelectElement.
	textInputElement onInstalledIn: self.

]

{ #category : #window }
ToSelectInnerContainerElement >> onWindowClosed [

	textInputElement onWindowClosed
]

{ #category : #window }
ToSelectInnerContainerElement >> onWindowOpened [

	textInputElement onWindowOpened
]

{ #category : #accessing }
ToSelectInnerContainerElement >> refresh [

	self subclassResponsibility 
]

{ #category : #initialization }
ToSelectInnerContainerElement >> removeFakeView [

	self subclassResponsibility 
]

{ #category : #accessing }
ToSelectInnerContainerElement >> selectedDataTextField [

	^ textInputElement selectedDataTextField
]

{ #category : #accessing }
ToSelectInnerContainerElement >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #accessing }
ToSelectInnerContainerElement >> textInputElement [

	^ textInputElement
]

{ #category : #initialization }
ToSelectInnerContainerElement >> textInputElementClass [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToSelectInnerContainerElement >> uninstallFakeViewIn: aSelectElement [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	fakeView onUninstalledIn: self.
	self removeFakeView.
	fakeView := nil
]

{ #category : #accessing }
ToSelectInnerContainerElement >> windowManager [ 

	^ windowManager
]
