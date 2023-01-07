Class {
	#name : #ToObservableCollection,
	#superclass : #Object,
	#traits : 'TToObservableCollection + TBlAnnouncerProvider',
	#classTraits : 'TToObservableCollection classTrait + TBlAnnouncerProvider classTrait',
	#instVars : [
		'list'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #'instance creation' }
ToObservableCollection class >> newFrom: aCollection [

	| l |
	l := self new.
	l unplugAnnouncerWhile: [ l addAll: aCollection ].
	^ l
]

{ #category : #initialization }
ToObservableCollection >> initialize [

	super initialize.
	self initializeObservableCollection 
]
