Class {
	#name : #ToFilterExperiment,
	#superclass : #Object,
	#instVars : [
		'initialData',
		'pattern',
		'isEditingSemaphore',
		'filterField',
		'listElement'
	],
	#category : #'Toplo-Examples'
}

{ #category : #'instance creation' }
ToFilterExperiment class >> open [
	<script>
	self new open 
]

{ #category : #'instance creation' }
ToFilterExperiment >> dataMatching: aPattern [

	^ aPattern ifEmpty: [ initialData ] ifNotEmpty: [
		  initialData select: [ :d | d beginsWith: pattern.
			  "d includesSubstring: pattern caseSensitive: false" ] ]
]

{ #category : #'instance creation' }
ToFilterExperiment >> filter [

	pattern ifNil: [ ^ self ].
	listElement data removeAll.
	listElement data addAll: (self dataMatching: pattern)
]

{ #category : #'instance creation' }
ToFilterExperiment >> filterWith: aStringOrText [

	initialData ifNil: [ self initializeFilter ].
	pattern := aStringOrText asString trimBoth.
	isEditingSemaphore signal
]

{ #category : #accessing }
ToFilterExperiment >> initialData: aCollection [

	initialData := aCollection.
	listElement data addAll: initialData 
]

{ #category : #'instance creation' }
ToFilterExperiment >> initializeFilter [

	isEditingSemaphore := Semaphore new.
	self spawnFilterUpdateThread
]

{ #category : #'instance creation' }
ToFilterExperiment >> open [

	| pane |
	pane := ToPane new beVertical; matchParent.
	filterField := ToTextField new.
	listElement := ToListElement new.
	listElement margin: (BlInsets all: 2).
	filterField margin: (BlInsets all: 2).
	pane addChild: listElement.
	pane addChild: filterField.

	self initialData: ((Smalltalk allClassesAndTraits sorted: [ :a :b | a name < b name]) collect: [:c | c name]).
	self initializeFilter.
	filterField whenTextEditedDo: [ self textUpdated ].
	pane openInOBlSpace 
]

{ #category : #'see class side' }
ToFilterExperiment >> seeClassSide [ 
]

{ #category : #'instance creation' }
ToFilterExperiment >> spawnFilterUpdateThread [
	"Runs in background, thank to Henrik Johansen for this"

	[ | oldPattern |
	oldPattern := nil.
	[ isEditingSemaphore wait.
	"If pattern has changed, see if we need to filter.
	If not, it's probably an extraneous signal received while we were waiting for 0.2 seconds, and we discard then till we end up waiting for filterChangeSemaphore again"
	oldPattern ~= pattern
		ifTrue: [ oldPattern := pattern.
			0.2 seconds wait.
			"Pattern still the same? If not, just loop again and end up waiting for another 0.2 secs"
			oldPattern = pattern
				ifTrue: [ self filter ] ] ] repeat ] forkAt: Processor userBackgroundPriority named: 'Toplo filter update'
]

{ #category : #'instance creation' }
ToFilterExperiment >> textUpdated [

	self filterWith: filterField text asString
]
