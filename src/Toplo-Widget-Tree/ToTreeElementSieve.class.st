Class {
	#name : #ToTreeElementSieve,
	#superclass : #ToListElementSieve,
	#instVars : [
		'originalSource'
	],
	#category : #'Toplo-Widget-Tree-Sieve'
}

{ #category : #accessing }
ToTreeElementSieve >> dataFilter: aValuable [
	" filter takes a wrapped data and a pattern as argument "

	super dataFilter: [ :item :pattern |
		item isRoot and: [ aValuable value: item unwrapped value: pattern ] ]
]

{ #category : #'api - hooks' }
ToTreeElementSieve >> installQueryRunnerIn: aTreeElement [

	originalData := aTreeElement dataAccessor newMirror.
	" the query is applied on the original data source "
	originalSource := aTreeElement dataSource newMirror.
	queryRunner onInstalledIn: originalSource
]

{ #category : #'api - hooks' }
ToTreeElementSieve >> uninstallQueryRunnerIn: aListElement [

	queryRunner onUninstalledIn: originalSource.
	originalSource unmirrored.
	originalSource := nil.
	originalData unmirrored.
	originalData := nil.

]
