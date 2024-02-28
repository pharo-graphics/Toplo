Class {
	#name : #ToSieveFilterQueryAppliedEvent,
	#superclass : #ToObservableCollectionQueryResultEvent,
	#instVars : [
		'sieve',
		'mute'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #accessing }
ToSieveFilterQueryAppliedEvent >> mute [

	^ mute
]

{ #category : #accessing }
ToSieveFilterQueryAppliedEvent >> mute: anObject [

	mute := anObject
]

{ #category : #sending }
ToSieveFilterQueryAppliedEvent >> sendTo: anObject [

	anObject sieveFilterQueryAppliedEvent: self
]

{ #category : #accessing }
ToSieveFilterQueryAppliedEvent >> sieve [

	^ sieve
]

{ #category : #accessing }
ToSieveFilterQueryAppliedEvent >> sieve: anObject [

	sieve := anObject
]
