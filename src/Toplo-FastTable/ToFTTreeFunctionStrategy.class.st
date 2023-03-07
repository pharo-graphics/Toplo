"
I am an abstract class that describe a Strategy to search/filter a ToFTTreeDataSource.

Description
----------------------

I have a dataSource that I can use and I can have a seach pattern which I use to search/filter the dataSource if needed.

I am use by a ToFTTreeDataSource and I help it with the possible ToFTFunction of his ToFTTableMorph. 

Public API and Key Messages
----------------------

- #search    	activate a search of the dataSource with the current pattern.
	
- #filter    	activate the filter of the dataSource with the current pattern.
	
- #searchWith: aString dataSource: dataSource 	is one of my constructors, it return the result of a search.

-#filterWith: aRegex dataSource: dataSource 	is an other of my constructor, it returns a new dataSource filtered by the regex. 
	
Example
----------------------

I am an abstract class. I should not be use.
 
Internal Representation and Key Implementation Points.
----------------------

    Instance Variables
	dataSource:		The data source I need to search/filter.
	pattern:		The search pattern in need to use,  this is a String or a Regex.

"
Class {
	#name : #ToFTTreeFunctionStrategy,
	#superclass : #Object,
	#instVars : [
		'dataSource',
		'pattern'
	],
	#category : #'Toplo-FastTable-Tree'
}

{ #category : #'instance creation' }
ToFTTreeFunctionStrategy class >> filterWith: aString dataSource: aDataSource [
	^ self new
		pattern: (self patternFromString: aString);
		dataSource: aDataSource;
		filter
]

{ #category : #updating }
ToFTTreeFunctionStrategy class >> patternFromString: aString [
	" do not throw an error if the pattern is bad - important in case of auto-accepting"

	^ [ aString asRegexIgnoringCase ]
		on: RegexSyntaxError
		do: [ :ex | '' asRegexIgnoringCase ]
]

{ #category : #'instance creation' }
ToFTTreeFunctionStrategy class >> searchWith: aString dataSource: aDataSource [
	^ self new pattern: aString; dataSource: aDataSource; search
]

{ #category : #accessing }
ToFTTreeFunctionStrategy >> dataSource [
	^ dataSource
]

{ #category : #accessing }
ToFTTreeFunctionStrategy >> dataSource: anObject [
	dataSource := anObject
]

{ #category : #action }
ToFTTreeFunctionStrategy >> filter [
	"I need to return a new dataSource that filter my dataSource."

	self subclassResponsibility
]

{ #category : #accessing }
ToFTTreeFunctionStrategy >> isMatching: anItem [
	^ (dataSource toString: anItem) beginsWith: pattern
]

{ #category : #action }
ToFTTreeFunctionStrategy >> optionalOperations [
	^ pattern isEmptyOrNil
		ifTrue: [ #() ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
ToFTTreeFunctionStrategy >> pattern: aStringOrRegex [
	pattern := aStringOrRegex
]

{ #category : #action }
ToFTTreeFunctionStrategy >> realSearch [
	"I need to return a collection of index that match the elements I find."

	self subclassResponsibility
]

{ #category : #action }
ToFTTreeFunctionStrategy >> search [
	^ self optionalOperations
		ifNotNil: [ :res | res ]
		ifNil: [ self realSearch]
]
