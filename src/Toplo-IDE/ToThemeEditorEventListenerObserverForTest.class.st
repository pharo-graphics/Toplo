Class {
	#name : #ToThemeEditorEventListenerObserverForTest,
	#superclass : #Object,
	#traits : 'TToThemeEditorEventListenersTreeObserver',
	#classTraits : 'TToThemeEditorEventListenersTreeObserver classTrait',
	#instVars : [
		'eventListener'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-eventListeners'
}

{ #category : #accessing }
ToThemeEditorEventListenerObserverForTest >> eventListener [
	^ eventListener
]

{ #category : #initialization }
ToThemeEditorEventListenerObserverForTest >> selectedEventListenerChanged: anEventListener [

	eventListener := anEventListener
]
