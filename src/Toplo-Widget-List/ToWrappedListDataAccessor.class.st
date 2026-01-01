Class {
	#name : #ToWrappedListDataAccessor,
	#superclass : #ToBasicListDataAccessor,
	#traits : 'TBlEventTarget + TBlDebug',
	#classTraits : 'TBlEventTarget classTrait + TBlDebug classTrait',
	#instVars : [
		'eventDispatcher'
	],
	#category : #'Toplo-Widget-List-WrappedList'
}

{ #category : #'t - data source wrapper - accessing dataSource' }
ToWrappedListDataAccessor >> dataItemWrapperClass [

	^ ToListDataItemWrapper
]

{ #category : #'event management accessing' }
ToWrappedListDataAccessor >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher 
]

{ #category : #initialization }
ToWrappedListDataAccessor >> initialize [ 

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self
]

{ #category : #'t - data source wrapper - accessing dataSource' }
ToWrappedListDataAccessor >> newWrapperForDataItem: anObject [

	^ self dataItemWrapperClass new
		  listElement: self listElement;
		  dataItem: anObject;
		  yourself
]

{ #category : #'api - hooks' }
ToWrappedListDataAccessor >> onInstalledInListElement: aListElement [

	super onInstalledInListElement: aListElement.
	listElement dataSource 
		  addEventHandlerOn: ToAbstractCollectionChangedEvent
		  do: [ :event | self dispatchEvent: event copy ]
]
