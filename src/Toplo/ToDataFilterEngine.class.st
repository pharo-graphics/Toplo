Class {
	#name : #ToDataFilterEngine,
	#superclass : #Object,
	#instVars : [
		'initialData',
		'pattern',
		'semaphore'
	],
	#category : #'Toplo-Widget-TextField'
}

{ #category : #'api - install/uninstall  hook' }
ToDataFilterEngine >> dataMatchingPattern [

	^ pattern ifEmpty: [ initialData ] ifNotEmpty: [
		  initialData select: [ :d | "d beginsWith: pattern."
			  d includesSubstring: pattern caseSensitive: false ] ]
]

{ #category : #filtering }
ToDataFilterEngine >> filter [

	pattern ifNil: [ ^ self ].
	self dataMatchingPattern
]

{ #category : #filtering }
ToDataFilterEngine >> filterWith: aStringOrText [

	initialData ifNil: [ self initializeFilter ].
	pattern := aStringOrText asString trimBoth.
	semaphore signal
]

{ #category : #accessing }
ToDataFilterEngine >> initialData: aCollection [

	initialData := aCollection.
]

{ #category : #accessing }
ToDataFilterEngine >> initializeFilter [

	semaphore := Semaphore new.
	self spawnFilterUpdateThread
]

{ #category : #'api - install/uninstall  hook' }
ToDataFilterEngine >> onInstalledIn: anElement [

	super onInstalledIn: anElement.

]

{ #category : #'api - install/uninstall  hook' }
ToDataFilterEngine >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.

]

{ #category : #'private filtering' }
ToDataFilterEngine >> spawnFilterUpdateThread [
	"Runs in background, thank to Henrik Johansen for this"

	[ | oldPattern |
	oldPattern := nil.
	[ semaphore wait.
	"If pattern has changed, see if we need to filter.
	If not, it's probably an extraneous signal received while we were waiting for 0.2 seconds, and we discard then till we end up waiting for filterChangeSemaphore again"
	oldPattern ~= pattern
		ifTrue: [ oldPattern := pattern.
			0.2 seconds wait.
			"Pattern still the same? If not, just loop again and end up waiting for another 0.2 secs"
			oldPattern = pattern
				ifTrue: [ self filter ] ] ] repeat ] forkAt: Processor userBackgroundPriority named: 'Toplo filter engine update'
]
