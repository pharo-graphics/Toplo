Class {
	#name : #ToObservableCollection,
	#superclass : #Object,
	#traits : 'TBlEventTarget + TToObservableCollection',
	#classTraits : 'TBlEventTarget classTrait + TToObservableCollection classTrait',
	#instVars : [
		'list',
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
	self initializeObservableCollection 
]

{ #category : #'t - observable collection - enumerating' }
ToObservableCollection >> with: aCollection do: aBlock [
	"aCollection must support #at:at: and be at least as large as the receiver."

	list with: aCollection do: aBlock
]
