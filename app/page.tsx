export default function Home() {
  return (
    <main className="flex min-h-screen items-center justify-center p-4">
      <div className="w-full max-w-sm rounded-2xl border border-[var(--border)] bg-[var(--background)] p-8">
        <h1 className="mb-6 text-center text-xl font-medium text-[var(--foreground)]">
          CryptoVault
        </h1>
        <p className="text-center text-sm text-[var(--muted-foreground)]">
          Your secure cryptocurrency wallet is ready.
        </p>
      </div>
    </main>
  );
}
