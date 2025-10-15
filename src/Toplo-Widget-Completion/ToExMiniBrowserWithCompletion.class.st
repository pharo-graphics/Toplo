Class {
	#name : #ToExMiniBrowserWithCompletion,
	#superclass : #ToExMiniBrowser,
	#category : #'Toplo-Widget-Completion-Example'
}

{ #category : #'instance creation' }
ToExMiniBrowserWithCompletion class >> open [
	<script>
	super open
]

{ #category : #initialization }
ToExMiniBrowserWithCompletion >> initializeCompletionEngine [

	| completionEngine |
	completionEngine := ToCompletionEngine new.
	completionEngine browser: self.
	completionEngine setEditor: codePane editor.

	codePane editorDo: [ :ed |
			ed
				addEventHandlerOn: AlbTextEditedEvent
				do: [ :event | "ed inspect.""completionEngine handleKeyDownBefore: event editor: codePane"
					 ] ].

	codePane
		addEventHandlerOn: BlKeyDownEvent
		do: [ :event | "		selectedSelector inspect."
				completionEngine showMenu.
				completionEngine
					handleKeyDownBefore: event
					editor: codePane editor ]
]

{ #category : #initialization }
ToExMiniBrowserWithCompletion >> newMainPane [

	| mp |
	mp := super newMainPane.
	self initializeCompletionEngine.
	^ mp
]
