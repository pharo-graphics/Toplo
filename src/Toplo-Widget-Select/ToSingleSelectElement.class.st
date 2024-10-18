Class {
	#name : #ToSingleSelectElement,
	#superclass : #ToSelectElement,
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #testing }
ToSingleSelectElement >> allowDeselection [

	^ self popupListElement primarySelectionMode deselectOnMouseDown
]

{ #category : #accessing }
ToSingleSelectElement >> allowDeselection: aBoolean [

	self popupListElement primarySelectionMode deselectOnMouseDown:
		aBoolean
]

{ #category : #accessing }
ToSingleSelectElement >> dataViewBuilder: aValuable [
	" aValuable takes 2 args: the dataItemView and the selected dataItem "

	self innerContainer dataViewBuilder: aValuable
]

{ #category : #accessing }
ToSingleSelectElement >> dataViewFactory: aValuable [

	self innerContainer dataViewFactory: aValuable
]

{ #category : #initialization }
ToSingleSelectElement >> defaultDataViewBuilder [

	^ [ :theView :theDataItem |
		theView addChild: (ToLabel text: theDataItem asString) ]
]

{ #category : #initialization }
ToSingleSelectElement >> defaultDataViewFactory [

	^ [ :container | ToSingleSelectDataItemView new ]
]

{ #category : #'instance creation' }
ToSingleSelectElement >> innerContainerClass [

	^ ToSingleSelectInnerContainerElement
]
