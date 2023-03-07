"
I'm a model for exposing method information.
I'm an example to be used in ToFTExampleMethodListDataSource and ToFTExampleMethodTableDataSource.
"
Class {
	#name : #ToFTExampleMethodModel,
	#superclass : #Object,
	#instVars : [
		'method',
		'actionIcon'
	],
	#category : #'Toplo-FastTable-Examples'
}

{ #category : #'instance creation' }
ToFTExampleMethodModel class >> method: aMethod [
	^ self basicNew
		initializeMethod: aMethod;
		yourself
]

{ #category : #'instance creation' }
ToFTExampleMethodModel class >> new [
	self error: 'Use #method:'
]

{ #category : #accessing }
ToFTExampleMethodModel >> actionOn: aBrowser [
	^ actionIcon ifNil: [ actionIcon := self createActionIconOn: aBrowser ]
]

{ #category : #factory }
ToFTExampleMethodModel >> createActionIconOn: aBrowser [
	^Smalltalk ui icons iconNamed: #scriptManager
]

{ #category : #initialization }
ToFTExampleMethodModel >> initializeMethod: aMethod [
	self initialize.
	method := aMethod
]

{ #category : #accessing }
ToFTExampleMethodModel >> method [
	^ method
]

{ #category : #accessing }
ToFTExampleMethodModel >> name [
	^ self method selector
]

{ #category : #accessing }
ToFTExampleMethodModel >> origin [
	^ self method origin
]

{ #category : #accessing }
ToFTExampleMethodModel >> protocol [
	^ self method protocol
]
