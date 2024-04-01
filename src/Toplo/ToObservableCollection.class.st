Class {
	#name : #ToObservableCollection,
	#superclass : #Object,
	#traits : 'TBlEventTarget + TToObservableCollection',
	#classTraits : 'TBlEventTarget classTrait + TToObservableCollection classTrait',
	#instVars : [
		'collection',
		'eventDispatcher'
	],
	#category : #'Toplo-Core-Collection'
}

{ #category : #'instance creation' }
ToObservableCollection class >> newFrom: aCollection [

	| l |
	l := self new.
	l addAll: aCollection.
	^ l
]

{ #category : #'t - observable collection - accessing' }
ToObservableCollection >> collection [

	^ collection

]

{ #category : #'event management accessing' }
ToObservableCollection >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #initialization }
ToObservableCollection >> initialize [

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self.
	collection := OrderedCollection new
]

{ #category : #'t - observable collection - copying' }
ToObservableCollection >> postCopy [

	collection := self collection copy
]

{ #category : #'t - observable collection - initialization' }
ToObservableCollection >> updateAllWith: aCollection [

	self notifyUpdateAllChangeAround: [
		self collection reset.
		self collection addAll: aCollection ]
]
