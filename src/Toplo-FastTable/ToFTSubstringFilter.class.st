"
I filter given strings by checking substrings inclusion
"
Class {
	#name : #ToFTSubstringFilter,
	#superclass : #ToFTFilter,
	#category : #'Toplo-FastTable-Functions'
}

{ #category : #matching }
ToFTSubstringFilter >> matches: aString [
	^aString includesSubstring: pattern caseSensitive: false
]
