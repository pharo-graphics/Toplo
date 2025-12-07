Class {
	#name : #ToWrappedListDataAccessor,
	#superclass : #Object,
	#traits : 'TToDataSourceWrapper + TBlEventTarget + TBlDebug',
	#classTraits : 'TToDataSourceWrapper classTrait + TBlEventTarget classTrait + TBlDebug classTrait',
	#instVars : [
		'listElement',
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

{ #category : #'t - data source wrapper - accessing' }
ToWrappedListDataAccessor >> listElement [ 

	^ listElement
]

{ #category : #'t - data source wrapper - accessing' }
ToWrappedListDataAccessor >> listElement: aListElement [

	listElement := aListElement
]
