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

{ #category : #'t - observable collection - accessing' }
ToObservableCollection >> collection: aCollection [

	collection := aCollection

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
	self collection: OrderedCollection new
]

{ #category : #'instance creation' }
ToObservableCollection >> newMirror [

	^ ToCollectionMirror new
		  mirrored: self;
		  yourself
]
