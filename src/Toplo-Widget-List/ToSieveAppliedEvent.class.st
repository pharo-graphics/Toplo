Class {
	#name : #ToSieveAppliedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sieve',
		'mute'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #accessing }
ToSieveAppliedEvent >> mute [

	^ mute ifNil: [ mute := false ]
]

{ #category : #accessing }
ToSieveAppliedEvent >> mute: anObject [

	mute := anObject
]

{ #category : #sending }
ToSieveAppliedEvent >> sendTo: anObject [

	anObject sieveAppliedEvent: self
]

{ #category : #accessing }
ToSieveAppliedEvent >> sieve [

	^ sieve
]

{ #category : #accessing }
ToSieveAppliedEvent >> sieve: aSieve [

	sieve := aSieve
]
