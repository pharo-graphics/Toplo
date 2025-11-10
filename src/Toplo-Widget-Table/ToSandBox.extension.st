Extension { #name : #ToSandBox }

{ #category : #'*Toplo-Widget-Table' }
ToSandBox class >> example_toTable1 [

	| table |
	table := ToTableElement new.
	table columns: {
			(ToTableColumn new
				 title: 'Name';
				 key: 'name';
				 dataIndex: 'name';
				 yourself).
			(ToTableColumn new
				 title: 'Number of methods';
				 key: 'methods';
				 dataIndex: 'numberOfMethods';
				 yourself) }.
	table dataAccessor addAll:
		(Smalltalk globals allClasses copyFrom: 1 to: 12).
	table openInSpace
]
