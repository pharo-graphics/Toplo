"
I am filter implemented by regex expressions

Internal Representation and Key Implementation Points.

    Instance Variables
	regex:		<RxMatcher>
"
Class {
	#name : #ToFTRegexFilter,
	#superclass : #ToFTFilter,
	#instVars : [
		'regex'
	],
	#category : #'Toplo-FastTable-Functions'
}

{ #category : #matching }
ToFTRegexFilter >> matches: aString [
	^(regex matchesIn: aString) notEmpty
]

{ #category : #accessing }
ToFTRegexFilter >> pattern: aString [
	super pattern: aString.

	regex := self patternFromString: aString
]

{ #category : #accessing }
ToFTRegexFilter >> patternFromString: aString [
	" do not throw an error if the pattern is bad - important in case of auto-accepting"

	^ [ aString asRegexIgnoringCase ]
		on: RegexSyntaxError
		do: [ :ex |  ]
]
