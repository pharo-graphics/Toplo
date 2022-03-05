Class {
	#name : #ToEditorSegmentHolder,
	#superclass : #BlInfiniteHolder,
	#category : #'Toplo-Editor-Model - Segment'
}

{ #category : #initialization }
ToEditorSegmentHolder >> createSegmentElement [
	"Create and return an that should represent a segment that I will hold.
	An element can be any of `BlElement withAllSubclasses`"
	<return: #BlElement>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
ToEditorSegmentHolder >> editor [
	"Return the attached text editor instance.
	Editor can not be nil"
	<return: #BrTextEditor>

	^ self infiniteElement editor
]

{ #category : #initialization }
ToEditorSegmentHolder >> initialize [
	super initialize.

	itemElement := self createSegmentElement
]

{ #category : #'as yet unclassified' }
ToEditorSegmentHolder >> onRecycled [
]

{ #category : #accessing }
ToEditorSegmentHolder >> segment: aBrEditorSegment [
	^ self subclassResponsibility
]
