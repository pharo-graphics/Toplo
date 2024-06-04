Class {
	#name : #ToSingleSelectElement,
	#superclass : #ToSelectElement,
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #accessing }
ToSingleSelectElement >> dataViewBuilder: aValuable [

	self innerContainer dataViewBuilder: aValuable
]

{ #category : #accessing }
ToSingleSelectElement >> dataViewFactory: aValuable [

	self innerContainer dataViewFactory: aValuable
]

{ #category : #initialization }
ToSingleSelectElement >> defaultDataViewBuilder [

	^ [ :theView :theDataItem |
	  theView selectedDataTextField text:
		  (theDataItem ifNil: [ '' ] ifNotNil: [ :d | d asString ]) ]
]

{ #category : #initialization }
ToSingleSelectElement >> defaultDataViewFactory [

	^ [ :container | ToSingleSelectDataItemView new ]
]

{ #category : #'instance creation' }
ToSingleSelectElement >> innerContainerClass [

	^ ToSingleSelectInnerContainerElement
]
