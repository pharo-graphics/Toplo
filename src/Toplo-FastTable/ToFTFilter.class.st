"
I am root of filter classes which are used by ToFTFilterFunction

My subclasses shoud implement method #matches: to filter given strings.

Public API and Key Messages

- matches: aString   
 
Internal Representation and Key Implementation Points.

    Instance Variables
	pattern:		<String>
"
Class {
	#name : #ToFTFilter,
	#superclass : #Object,
	#instVars : [
		'pattern'
	],
	#category : #'Toplo-FastTable-Functions'
}

{ #category : #'instance creation' }
ToFTFilter class >> pattern: aString [
	^self new
		pattern: aString
]

{ #category : #matching }
ToFTFilter >> matches: aString [

	self subclassResponsibility
]

{ #category : #accessing }
ToFTFilter >> pattern [
	^ pattern
]

{ #category : #accessing }
ToFTFilter >> pattern: anObject [
	pattern := anObject
]
