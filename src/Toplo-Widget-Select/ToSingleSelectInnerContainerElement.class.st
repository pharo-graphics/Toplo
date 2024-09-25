Class {
	#name : #ToSingleSelectInnerContainerElement,
	#superclass : #ToElement,
	#traits : 'TToSelectInnerContainerElement',
	#classTraits : 'TToSelectInnerContainerElement classTrait',
	#instVars : [
		'selectElement',
		'textInputElement',
		'fakeDataView',
		'dataView',
		'dataViewFactory',
		'dataViewBuilder',
		'fakeDataItem',
		'currentSelectedIndex'
	],
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #'instance creation' }
ToSingleSelectInnerContainerElement class >> onSelectElement: aSelectElement [

	^ self basicNew
		  selectElement: aSelectElement;
		  initialize
]

{ #category : #accessing }
ToSingleSelectInnerContainerElement >> dataViewBuilder: aValuable [

	" aValuable takes 2 args: the dataItemView and the selected dataItem "
	dataViewBuilder := aValuable.
	self refresh
]

{ #category : #accessing }
ToSingleSelectInnerContainerElement >> dataViewFactory [

	^ dataViewFactory
]

{ #category : #accessing }
ToSingleSelectInnerContainerElement >> fakeDataItem: aData [

	fakeDataItem := aData.
	fakeDataView ifNotNil: [
		self uninstallFakeDataView.
		self installFakeDataView ]
]

{ #category : #initialization }
ToSingleSelectInnerContainerElement >> initialize [

	super initialize.
	self
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].

	dataViewFactory := selectElement defaultDataViewFactory.
	dataViewBuilder := selectElement defaultDataViewBuilder.
		
	self installTextInputElement.
	self installDataView.
	self installFakeDataView.

]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> installDataView [
		
	" add the unique view for the selected data item "
	dataView := self newDataView.
	dataView middleElement: textInputElement.
	dataView id: #dataView.
	self addChild: dataView
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> installFakeDataView [
		
	" add the fake node (to keep a constant minimum height )"
	fakeDataView := self newDataView.
	dataViewBuilder cull: fakeDataView cull: fakeDataItem.
	fakeDataView id: #fakeDataView.
	fakeDataView width: 0.
	self addChild: fakeDataView before: dataView.

]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> installTextInputElement [ 

	textInputElement := self textInputElementClass new.
	textInputElement onInstalledIn: self
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> isMultipleSelection [ 

	^ false
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> newDataView [

	^ (dataViewFactory cull: self)
		  container: self;
		  yourself
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> refresh [

	| selectedIndex dataItem selectionModel originalData newResultView changedEvent |
	selectionModel := self windowManager sieve selectionModel.
	originalData := self windowManager sieve originalData.
	selectedIndex := selectionModel isEmpty
		                 ifTrue: [ 0 ]
		                 ifFalse: [ selectionModel firstIndex ].
	currentSelectedIndex = selectedIndex ifTrue: [ ^ self ].
	currentSelectedIndex := selectedIndex.
	self inputTextField text: '' asRopedText.

	dataView startContainer removeChildren.
	newResultView := ToSingleSelectResultView new
		                 textInputElement: textInputElement;
		                 yourself.
	dataView startContainer addChild: newResultView.

	selectedIndex isZero
		ifTrue: [ self selectedDataTextField text: '' asRopedText ]
		ifFalse: [
			dataItem := originalData at: selectedIndex.
			dataViewBuilder cull: newResultView cull: dataItem ].
		
	changedEvent := ToSingleSelectChangedEvent new.
	changedEvent selectedData: dataItem.
	changedEvent selectedIndex: selectedIndex.
	selectElement dispatchEvent: changedEvent
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> selectElement [

	^ selectElement
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> selectElement: aSelectElement [

	selectElement := aSelectElement
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> textInputElement [

	^ textInputElement 
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> textInputElementClass [

	^ ToSingleSelectTextInputElement 
]

{ #category : #'t - select inner container' }
ToSingleSelectInnerContainerElement >> uninstallFakeDataView [
		
	self removeChild: fakeDataView

]
