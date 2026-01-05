Class {
	#name : #ToSingleSelectHeaderElement,
	#superclass : #ToElement,
	#traits : 'TToSelectHeaderElement + TToElementWithPlaceholder',
	#classTraits : 'TToSelectHeaderElement classTrait + TToElementWithPlaceholder classTrait',
	#instVars : [
		'selectElement',
		'fakeDataView',
		'dataView',
		'dataViewFactory',
		'dataViewBuilder',
		'fakeDataItem',
		'currentSelectedIndex',
		'filterTextField'
	],
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #'instance creation' }
ToSingleSelectHeaderElement class >> onSelectElement: aSelectElement [

	^ self basicNew
		  selectElement: aSelectElement;
		  initialize
]

{ #category : #'t - select inner container' }
ToSingleSelectHeaderElement >> addFilterTextField: aFilterTextField [

	self addChild: aFilterTextField
]

{ #category : #accessing }
ToSingleSelectHeaderElement >> dataView [
	" return the element containing the selection result "

	^ dataView
]

{ #category : #accessing }
ToSingleSelectHeaderElement >> dataViewBuilder: aValuable [
	" aValuable takes 2 args: the dataItemView and the selected dataItem "

	dataViewBuilder := aValuable.
	self updateFromPopupListSelection.
	fakeDataItem ifNil: [ ^ self ].
	self reinstallFakeDataView
]

{ #category : #accessing }
ToSingleSelectHeaderElement >> dataViewFactory [

	^ dataViewFactory
]

{ #category : #initialization }
ToSingleSelectHeaderElement >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #accessing }
ToSingleSelectHeaderElement >> fakeDataItem: aData [

	fakeDataItem := aData.
	self reinstallFakeDataView
]

{ #category : #'t - select inner container' }
ToSingleSelectHeaderElement >> filterTextField [

	^ filterTextField 
]

{ #category : #'t - select inner container' }
ToSingleSelectHeaderElement >> filterTextField: aTextField [

	filterTextField := aTextField
]

{ #category : #initialization }
ToSingleSelectHeaderElement >> initialize [

	super initialize.
	self
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].

	dataViewFactory := selectElement defaultDataViewFactory.
	dataViewBuilder := selectElement defaultDataViewBuilder.
		
	self installDataView.
	self installFakeDataView.
	self installFilterTextField

]

{ #category : #initialization }
ToSingleSelectHeaderElement >> installDataView [
		
	" add the unique view for the selected data item "
	dataView := self newDataView.
	dataView id: #dataView.
	self addChild: dataView
]

{ #category : #initialization }
ToSingleSelectHeaderElement >> installFakeDataView [
	" add the fake node (to keep a constant minimum height )"

	fakeDataView := self newDataView.
	dataViewBuilder cull: fakeDataView cull: fakeDataItem.
	fakeDataView id: #fakeDataView.
	fakeDataView width: 0.
	self addChild: fakeDataView before: dataView
]

{ #category : #skin }
ToSingleSelectHeaderElement >> installRawStyle [

	super installRawStyle.
	self padding: (BlInsets all: 5)

]

{ #category : #testing }
ToSingleSelectHeaderElement >> isMultipleSelection [ 

	^ false
]

{ #category : #initialization }
ToSingleSelectHeaderElement >> newDataView [

	^ dataViewFactory cull: self
]

{ #category : #initialization }
ToSingleSelectHeaderElement >> reinstallFakeDataView [
		
	self uninstallFakeDataView.
	self installFakeDataView 

]

{ #category : #accessing }
ToSingleSelectHeaderElement >> sample: aDataItem [

	self fakeDataItem: aDataItem
]

{ #category : #'t - select inner container' }
ToSingleSelectHeaderElement >> selectElement [

	^ selectElement
]

{ #category : #'t - select inner container' }
ToSingleSelectHeaderElement >> selectElement: aSelectElement [

	selectElement := aSelectElement
]

{ #category : #initialization }
ToSingleSelectHeaderElement >> uninstallFakeDataView [
		
	self removeChild: fakeDataView

]

{ #category : #'t - select inner container' }
ToSingleSelectHeaderElement >> updateFromPopupListSelection [

	| selectedIndex  selectionModel selectedDataItems |
	selectElement showHidePlaceholder.
	selectedDataItems := selectElement selectedDataItems.
	selectionModel := self manager sieve selectionModel.
	selectedIndex := selectionModel isEmpty
		                 ifTrue: [ 0 ]
		                 ifFalse: [ selectionModel firstIndex ].
	currentSelectedIndex = selectedIndex ifTrue: [ ^ self ].
	currentSelectedIndex := selectedIndex.
	dataView removeChildren.

	selectedDataItems ifEmpty: [ ^ self ].
	dataViewBuilder cull: dataView cull: selectedDataItems first
]
